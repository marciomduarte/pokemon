//
//  PokemonDetailsViewModel.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//
//  This ViewModel get pokemon additional information before update the details layout
//  Class used on PokemonDetailsViewController
//

import Foundation
import UIKit

class PokemonDetailsViewModel: NSObject {

    // MARK: - Private vars
    private(set) var pokemon: Pokemon! {
        didSet {
            self.bindPokemonDetail(self.pokemon)
        }
    }

    /// pokemonServiceAPI var used to call the protocol to data/informations
    private var pokemonServiceAPI: PokemonServiceProtocol

    // MARK: - Public vars
    /// bind the pokemons details.
    /// This method return to view the pokemon detail requested by the user
    var bindPokemonDetail: ((_ pokemons: Pokemon) -> ()) = {_ in}

    /// bind the pokemons details.
    /// This method return to view the pokemon detail requested by the user
    var errorGetPokemon: (() -> ()) = {}

    /// Pokemon Id of the pokemon.
    /// Used to setted the pokemonId selected by the user
    var pokemonId: Int = -1 {
        didSet {
            self.getPokemonDetails(withPokemonId: self.pokemonId)
        }
    }

    // MARK: - Life Cycles
    /// Init Pokemon service api  protocol.
    init (pokemonAPI: PokemonServiceProtocol = PokemonWebServices()) {
        self.pokemonServiceAPI = pokemonAPI
    }

    /// Get pokemon details method.
    /// Method receive the pokemonId and return the details of the pokemons.
    public func getPokemonDetails(withPokemonId pokemonId: Int) {
        Task { [weak self] in
            guard let self = self else {
                return
            }

            do {
                var pokemon = try await self.pokemonServiceAPI.getSearchPokemon(withPokemonIdOrName: String(pokemonId))
                if pokemon == nil {
                    let errorData: [String: Error] = [errorType: PokemonsError.NoMorePokemons]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: PokemonErrorServiceNotification), object: errorData)
                    self.errorGetPokemon()
                } else {
                    pokemon = await PokemonsUtils().getPokemonImages(withPokemon: pokemon!)
                    self.pokemon = pokemon
                }

            } catch {
                let errorData: [String: Error] = [errorType: error]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: PokemonErrorServiceNotification), object: errorData)
                self.errorGetPokemon()
            }
        }
    }
}
