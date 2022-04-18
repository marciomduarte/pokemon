//
//  PokemonListDataSource.swift
//  pokemon
//
//  Created by Márcio Duarte on 12/04/2022.
//
// Class with the delegates and data source of the collection view used to shown the pokemons

import Foundation
import UIKit

class PokemonListDataSource<CELL : UICollectionViewCell, T>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Private vars
    /// Identifier of the cell used on collection
    private var cellIdentifier: String!

    /// List of pokemons
    private var pokemons: [Pokemon]?

    /// Flag used to check if the cell to present is a loading cell
    private var hasNextPage: Bool = false

    /// Flag used to know if the user have something write on search bar
    private var isSearchActive: Bool = false

    // MARK: - Public vars
    /// Configuration of the cell that will be returned to the
    var configureCell: (CELL, Pokemon, Bool, Bool) -> () = {_, _, _, _ in}

    /// Method used to inform the view about the need to ask for more pokemons to present
    var getMorePokemons:(() -> Void)? = nil

    /// Method used to return to view the pokemon click on cell
    var seeMoreWasClicked:((Int) -> Void)? = nil

    override init() {
        super.init()
    }

    init(WithCellIdentifier cellIdentifier: String, andPokemons pokemons: T, andIsLoadingCell isLoadingCell: Bool, andIsSearchActive searchActive: Bool, andCellConfig cellConfig: @escaping (CELL, Any, Bool, Bool) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.pokemons = pokemons as? [Pokemon]
        self.configureCell = cellConfig
        self.hasNextPage = isLoadingCell
        self.isSearchActive = searchActive
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.pokemons?.count ?? 0) + (self.isSearchActive ? 0 : 1)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as! CELL

        if (self.pokemons?.count ?? 0) - 1 >= indexPath.row {
            let pokemon = self.pokemons?[indexPath.row]

            self.configureCell(cell, pokemon!, false, self.isSearchActive)
        } else {
            let emptyPokemon: Pokemon = Pokemon(id: nil, name: nil, url: nil, weight: nil, height: nil, sprites: nil, types: nil, abilities: nil, stats: nil)
            self.configureCell(cell, emptyPokemon, true, self.isSearchActive)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Fetch more pokemons when 10 pokemons are missing to display
        if (self.pokemons?.count ?? 0) - 10 == indexPath.row  && self.hasNextPage {
            self.getMorePokemons?()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let pokemon = self.pokemons?[indexPath.row] {
            self.seeMoreWasClicked?(pokemon.id ?? 0)
        }
    }

}
