//
//  PokemonListViewController.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//
//  Class to show all the pokemons retrived by the service api
//  This class contains:
//      SearchBar: To search a pokemon by name or id
//      PokemonListView: To shown the pokemons and get more information about them.

import UIKit

class PokemonListViewController: UIViewController, UISearchBarDelegate {

    // MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var pokemonSearchBar: UISearchBar!
    @IBOutlet private weak var pokemonListView: PokemonListView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.ErrorNotification(notification:)), name: Notification.Name(PokemonErrorServiceNotification), object: nil)

        self.hideKeyboardWhenTappedAround()

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIAccessibility.post(notification: .screenChanged, argument: self.titleLabel);
        }
    }

    // Go to pokemons details after click on cell
    private func goToPokemonDetail(withPokemonId pokemonId: Int, andPokemons pokemons: [Pokemon]) {
        if pokemonId == 0 {
            return
        }

        let pokemonDetailsVC: PokemonDetailsViewController = PokemonDetailsViewController()
        pokemonDetailsVC.pokemonId = pokemonId
        pokemonDetailsVC.pokemons = pokemons
        self.navigationController?.pushViewController(pokemonDetailsVC, animated: true)
    }

    // This method receive the text inserted by the user on search bar.
    private func searchPokemon(withSearchBar searchBar: UISearchBar) {
        self.pokemonSearchBar.endEditing(true)

        if (searchBar.searchTextField.text ?? "").count > 0 {
            self.pokemonListView.pokemonsSearchText = searchBar.searchTextField.text?.lowercased() ?? ""
        } else {
            self.resetSearchbarAndReloadData()
        }
    }

    private func resetSearchbarAndReloadData() {
        self.pokemonListView.reloadPokemonList()
    }

    // MARK: - Search Bar delegate
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchPokemon(withSearchBar: searchBar)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchPokemon(withSearchBar: searchBar)
    }

    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetSearchbarAndReloadData()
    }
}
