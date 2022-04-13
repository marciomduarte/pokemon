//
//  PokemonDetailsViewModel.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import Foundation

class PokemonDetailsViewModel: NSObject {

    // MARK: - Private vars
    private(set) var pokemon: Pokemon! {
        didSet {
            self.bindPokemonDetail(self.pokemon)
        }
    }

    // MARK: - Public vars
    var bindPokemonDetail: ((_ pokemons: Pokemon) -> ()) = {_ in}
    var pokemonId: Int = -1 {
        didSet {
            self.getPokemonDetails(withPokemonId: self.pokemonId)
        }
    }

    override init() {
        super.init()
    }

    public func getPokemonDetails(withPokemonId pokemonId: Int) {
        Task { [weak self] in
            guard let self = self else {
                return
            }

            do {
                self.pokemon = try await PokemonWebServices.getAdditionalInformation(withPokemonId: self.pokemonId)
            } catch {
                print("error")
            }
        }
    }

}
