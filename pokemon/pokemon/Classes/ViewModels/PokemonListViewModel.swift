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
    /// Var with number of cell on screen
    var numberOfElementsOnScreen: Int? {
        willSet {
            self.numberOfPokemonsFetched = (newValue ?? 0) * 2
            self.fetchPokemons(withOffSet: self.offSet)
        }
    }

    /// Var used to send pokemons to view
    var bindPokemonsList: ((_ pokemons: [Pokemon]) -> ()) = {_ in}

    /// Var used to send searched pokemons to view
    var bindSearchedPokemons: ((_ pokemons: [Pokemon]) -> ()) = {_ in}

    // MARK: - Life Cycle
    /// Init serviceAPI protocol
    init (pokemonAPI: PokemonServiceProtocol = PokemonWebServices()) {
        self.pokemonServiceAPI = pokemonAPI
    }

    /// Get Pokemon images (Front and back image)
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

    /// Fetch pokemons
    public func fetchPokemons(withOffSet offSet: Int) {
        if !self.hasNextPage {
            return
        }

        if self.pokemons.count == 0 {
            UIApplication.shared.topMostViewController()?.showActivityIndicator()
        }

        Task { [weak self] in
            guard let self = self else {
                return
            }

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
                let errorData: [String: Error] = [errorType: error]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: PokemonErrorServiceNotification), object: errorData)
            }
        }
    }


    /// Function used to update collectionView
    /// Used to update collection when user click on cancel button on search bar
    public func getPokemonsToSearch(withSearchText searchText: String) {
        var searchPokemon: [Pokemon] = []

        UIApplication.shared.topMostViewController()?.showActivityIndicator()

        self.pokemons?.forEach({ pokemonFiltered in
            if PokemonsUtils().isNumber(withString: searchText), pokemonFiltered.id == Int(searchText) {
                searchPokemon.append(pokemonFiltered)
            } else if pokemonFiltered.name == searchText.lowercased() {
                searchPokemon.append(pokemonFiltered)
            }

            if searchPokemon.count > 0 {
            }
        })

        if (searchPokemon.isEmpty) {
            Task {
                do {
                    var newPokemon: Pokemon? = try await self.pokemonServiceAPI.getSearchPokemon(withPokemonIdOrName: searchText)

                    if (newPokemon != nil) {
                        let aux: Pokemon = await self.getPokemonImages(withPokemon: newPokemon!)
                        newPokemon = aux
                        self.bindSearchedPokemons([newPokemon!])
                    } else {
                        self.bindSearchedPokemons([])
                        let errorData: [String: Error] = [errorType: PokemonsError.PokemonNoExist]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PokemonErrorServiceNotification), object: errorData)
                    }

                    await UIApplication.shared.topMostViewController()?.hideActivityIndicator()
                } catch {
                    let errorData: [String: Error] = [errorType: error]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: PokemonErrorServiceNotification), object: errorData)
                }
            }
        } else {
            UIApplication.shared.topMostViewController()?.hideActivityIndicator()
        }

        self.bindSearchedPokemons(searchPokemon)
    }
}
