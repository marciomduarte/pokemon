//
//  PokemonDetailsViewController.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var pokemonDetailsTopView: PokemonDetailsTopView!
    @IBOutlet weak var pokemonDetailsBottomView: PokemonDetailsBottomView!
    @IBOutlet weak var pokemonDetailsBottomViewHeightConstraint: NSLayoutConstraint!

    // MARK: - Private vars
    private var pokemonListViewModel: PokemonDetailsViewModel!
    private var pokemon: Pokemon! {
        didSet {
            self.pokemonDetailsTopView.pokemon = self.pokemon
            self.pokemonDetailsBottomView.pokemon = self.pokemon
        }
    }

    // MARK: Public vars
    public var pokemonId: Int = -1
    public var pokemons: [Pokemon]!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    private func setupUI() {
        // Define backgroundColor
        self.view.backgroundColor = UIColor.pokemonListBackgroundColor

        self.pokemonListViewModel = PokemonDetailsViewModel()
        if let pokemonFetched = self.pokemons.first(where: { $0.id == self.pokemonId}) {
            self.pokemon = pokemonFetched
        } else {
            self.pokemonListViewModel.pokemonId = self.pokemonId
        }

        self.pokemonListViewModel.bindPokemonDetail = { pokemon in
            self.pokemon = pokemon
        }

        self.pokemonDetailsBottomViewHeightConstraint.constant = pokemonDetailsBottomView.bottomView.frame.maxY - self.pokemonDetailsBottomView.imageViewContainer.frame.minY
    }

}
