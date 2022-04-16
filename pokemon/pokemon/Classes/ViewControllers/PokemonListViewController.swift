//
//  PokemonListViewController.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import UIKit

class PokemonListViewController: UIViewController, UISearchBarDelegate {

    // MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var pokemonSearchBar: UISearchBar!
    @IBOutlet private weak var pokemonListView: PokemonListView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(PokemonErrorServiceNotification), object: nil)

        self.hideKeyboardWhenTappedAround()

        self.showActivityIndicator()

        self.setupUI()
    }

    private func setupUI() {
        // Define backgroundColor
        self.view.backgroundColor = UIColor.pokemonListBackgroundColor

        // Define Title label
        self.titleLabel.text = NSLocalizedString("pokemon.app.name", comment: "")
        self.titleLabel.pokemonListTitleLabelStyle()

        // Define and config searchBar
        self.pokemonSearchBar.barTintColor = UIColor.pokemonListBackgroundColor
        self.pokemonSearchBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.pokemonSearchBar.placeholder = NSLocalizedString("pokemon.empty.search.placeholder", comment: "")
        self.pokemonSearchBar.tintColor = UIColor.pokemonRedColor
        self.pokemonSearchBar.searchBarStyle = .prominent
        self.pokemonSearchBar.delegate = self

        self.pokemonListView.seeMorePokemonDetails = { pokemonId, pokemons in
            self.goToPokemonDetail(withPokemonId: pokemonId, andPokemons: pokemons ?? [])
        }
    }

    private func goToPokemonDetail(withPokemonId pokemonId: Int, andPokemons pokemons: [Pokemon]) {
        if pokemonId == 0{
            return
        }

        let pokemonDetailsVC: PokemonDetailsViewController = PokemonDetailsViewController()
        pokemonDetailsVC.pokemonId = pokemonId
        pokemonDetailsVC.pokemons = pokemons
        self.navigationController?.pushViewController(pokemonDetailsVC, animated: true)
    }

    private func searchPokemon(wiehtSearchBar searchBar: UISearchBar) {
        self.pokemonSearchBar.endEditing(true)

        self.showActivityIndicator()
        if (searchBar.searchTextField.text ?? "").count > 0 {
            self.pokemonListView.pokemonsSearchText = searchBar.searchTextField.text ?? ""
        } else {
            self.resetSearchbarAndReloadData()
        }
    }

    private func resetSearchbarAndReloadData() {
        self.pokemonSearchBar.showsCancelButton = false
        self.pokemonListView.reloadPokemonList()
    }

    // MARK: - Search Bar delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.pokemonSearchBar.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchPokemon(wiehtSearchBar: searchBar)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchPokemon(wiehtSearchBar: searchBar)
    }

    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetSearchbarAndReloadData()
    }


}
