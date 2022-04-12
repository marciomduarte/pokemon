//
//  PokemonFakeSplashScreenViewController.swift
//  pokemon
//
//  Created by Márcio Duarte on 12/04/2022.
//

import UIKit

class PokemonFakeSplashScreenViewController: UIViewController {

    // MARK: - Private vars
    var pokemonsList: PokemonList! {
        willSet {
            self.initPokemonList(withPokemonList: newValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getPokemonList()
    }

    private func getPokemonList() {
        Task {
            var pokemonsList = await PokemonWebServices.getPokemonList(withNewPage: 0)

            let pokemons: [Pokemon] = pokemonsList?.results ?? []
            var newPokemons: [Pokemon] = []
            for var pokemon: Pokemon in pokemons {
                pokemon = await PokemonWebServices.getAdditionalInformation(withURLString: pokemon.url!)
                newPokemons.append(pokemon)
            }

            pokemonsList?.results = newPokemons
            self.pokemonsList = pokemonsList
        }
    }

    private func initPokemonList(withPokemonList pokemonList: PokemonList) {
        let pokemonListVC: PokemonListViewController = PokemonListViewController()
        pokemonListVC.pokemonsList = pokemonList

        self.navigationController?.setViewControllers([pokemonListVC], animated: true)

    }
}
