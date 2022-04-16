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
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(PokemonErrorServiceNotification), object: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.pokemonRedColor
        self.navigationController?.navigationBar.topItem?.title = ""

        self.showActivityIndicator()

        self.setupUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(Notification.Name(PokemonErrorServiceNotification))
    }

    private func setupUI() {
        // Define backgroundColor
        self.view.backgroundColor = UIColor.pokemonListBackgroundColor

        self.pokemonListViewModel = PokemonDetailsViewModel()
        if let pokemonFetched = self.pokemons.first(where: { $0.id == self.pokemonId}) {
            self.pokemon = pokemonFetched

            self.hideActivityIndicator()
        } else {
            self.pokemonListViewModel.pokemonId = self.pokemonId
        }

        self.pokemonListViewModel.bindPokemonDetail = { pokemon in
            self.pokemon = pokemon

            self.hideActivityIndicator()
        }

        self.pokemonDetailsBottomViewHeightConstraint.constant = pokemonDetailsBottomView.bottomView.frame.maxY - self.pokemonDetailsBottomView.imageViewContainer.frame.minY
    }

}
