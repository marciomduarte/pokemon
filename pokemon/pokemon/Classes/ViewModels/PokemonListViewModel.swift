//
//  PokemonListViewModel.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import UIKit

class PokemonListViewModel: NSObject {
    // MARK: - Private vars
    private(set) var pokemonsList: PokemonList! {
        didSet {
            self.bindPokemonsList(self.pokemonsList)
        }
    }

    private var offSet: Int = 0
    private var nextPage: Bool = true

    // MARK: - Pubic vars
    var bindPokemonsList: ((_ pokemonList: PokemonList) -> ()) = {_ in}

    override init() {
        super.init()

        self.getPokemonList(withOffSet: self.offSet)
    }

    public func getPokemonList(withOffSet offSet: Int) {
        Task {
            var pokemonsList = await PokemonWebServices.getPokemonList(withoffSet: offSet)

            let pokemons: [Pokemon] = pokemonsList?.results ?? []
            var newPokemons: [Pokemon] = []
            for var pokemon: Pokemon in pokemons {
                pokemon = await PokemonWebServices.getAdditionalInformation(withURLString: pokemon.url!)
                newPokemons.append(pokemon)
            }

            pokemonsList?.results = newPokemons
            self.pokemonsList = pokemonsList

            self.configServiceVars(withOffSet: offSet, andNextPokemons: self.pokemonsList.next ?? nil)
        }
    }

    public func getMorePokemon(withOffset offSet: Int) {

    }

    private func configServiceVars(withOffSet offSet: Int, andNextPokemons nextPokemons: String?) {
        self.nextPage = nextPokemons?.count != nil ? true : false
        self.offSet += offSet
    }

}
