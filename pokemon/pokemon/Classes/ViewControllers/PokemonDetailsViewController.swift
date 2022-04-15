//
//  PokemonDetailsViewController.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var pokemonDetailsBottomView: PokemonDetailsBottomView!

    // MARK: - Private vars
    private var pokemonListViewModel: PokemonDetailsViewModel!
    private var pokemon: Pokemon! {
        didSet {
            self.pokemonDetailsBottomView.pokemon = self.pokemon
        }
    }

    // MARK: Public vars
    public var pokemonId: Int = -1
    public var lisOfPokemons: [Pokemon]!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    private func setupUI() {
        // Define backgroundColor
        self.view.backgroundColor = UIColor.pokemonListBackGroundColor

        self.pokemonListViewModel = PokemonDetailsViewModel()
        self.pokemonListViewModel.pokemonId = self.pokemonId
        self.pokemonListViewModel.bindPokemonDetail = { pokemon in
            self.pokemon = pokemon
        }

    }

}
