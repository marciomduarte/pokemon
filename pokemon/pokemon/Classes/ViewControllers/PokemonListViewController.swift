//
//  PokemonListViewController.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import UIKit

class PokemonListViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var pokemonSearchBar: UISearchBar!
    @IBOutlet private weak var pokemonListView: PokemonListView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    private func setupUI() {
        // Define backgroundColor
        self.view.backgroundColor = UIColor.pokemonListBackGroundColor

        // Define Title label
        self.titleLabel.text = NSLocalizedString("pokemon.app.name", comment: "")
        self.titleLabel.pokemonListTitleLabelStyle()

        // Define and config searchBar
        self.pokemonSearchBar.barTintColor = UIColor.pokemonListBackGroundColor
        self.pokemonSearchBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)

        self.pokemonListView.seeMorePokemonDetails = { pokemon in
            self.goToPokemonDetail(withPokemon: pokemon)
        }
    }

    private func goToPokemonDetail(withPokemon pokemon: Pokemon) {
        let pokemonDetailsVC: PokemonDetailsViewController = PokemonDetailsViewController()
        pokemonDetailsVC.pokemon = pokemon
        self.navigationController?.pushViewController(pokemonDetailsVC, animated: true)
    }

}
