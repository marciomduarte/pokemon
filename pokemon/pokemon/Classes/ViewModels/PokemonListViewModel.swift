//
//  PokemonListViewModel.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import UIKit

class PokemonListViewModel: NSObject {

    // MARK: - Private vars
    private(set) var pokemons: [Pokemon]! = [] {
        didSet {
            self.bindPokemonsList(self.pokemons)
        }
    }

    private var pokemonServiceAPI: PokemonServiceProtocol

    /// Number of pokemons
    private var numberOfPokemonsFetched: Int = 0

    /// Offset of next pokemons
    private var offSet: Int = 0

    /// Used to check if we have more pokemons
    private var hasNextPage: Bool = true

    // MARK: - Public vars
    var numberOfElementsOnScreen: Int? {
        willSet {
            self.numberOfPokemonsFetched = (newValue ?? 0) * 2
            self.getPokemonList(withOffSet: self.offSet)
        }
    }

    var bindPokemonsList: ((_ pokemons: [Pokemon]) -> ()) = {_ in}

    // MARK: - Life Cycle
    init (pokemonAPI: PokemonServiceProtocol = PokemonWebServices()) {
        self.pokemonServiceAPI = pokemonAPI
    }

    public func getPokemonList(withOffSet offSet: Int) {
        self.fetchPokemons(withOffSet: offSet)
    }

    private func fetchPokemons(withOffSet offSet: Int) {
        if !self.hasNextPage {
            return
        }

        Task {
            do {
                let pokemonsList = try await self.pokemonServiceAPI.getPokemonList(withNumberOfElements: self.numberOfPokemonsFetched, withOffSet: offSet)

                let pokemonResult: [Pokemon] = pokemonsList?.results ?? []
                var newPokemons: [Pokemon] = []
                for var pokemonObject: Pokemon? in pokemonResult {
                    pokemonObject = try await self.pokemonServiceAPI.getAdditionalInformation(withURLString: pokemonObject?.url ?? "")
                    if var newPokemonObject: Pokemon = pokemonObject {
                    newPokemonObject = await self.getPokemonImages(withPokemon: newPokemonObject)
                        newPokemons.append(newPokemonObject)
                    }
                }
                self.pokemons.append(contentsOf: newPokemons)

                self.offSet += self.numberOfPokemonsFetched
                self.hasNextPage = offSet < (pokemonsList?.count ?? 0)
            } catch {
                print(error)
            }
        }
    }

    private func getPokemonImages(withPokemon pokemon: Pokemon) async -> Pokemon {
        var newPokemon = pokemon
        var frontPokemonImageData: Data? = nil
        var backPokemonImageData: Data? = nil

        if let frontImageUrl = pokemon.sprites?.front_default, let frontImageData: Data = try? await self.pokemonServiceAPI.getImage(withURLString: frontImageUrl) {
            frontPokemonImageData = frontImageData
        }

        if let backImageUrl = pokemon.sprites?.back_default, let backImageData: Data = try? await self.pokemonServiceAPI.getImage(withURLString: backImageUrl) {
            backPokemonImageData = backImageData
        }

        newPokemon.setFrontAndBackPokemonImage(withFrontImage: frontPokemonImageData, andBackImage: backPokemonImageData)

        return newPokemon
    }
}
