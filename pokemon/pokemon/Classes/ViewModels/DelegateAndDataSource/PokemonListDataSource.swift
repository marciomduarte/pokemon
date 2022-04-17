//
//  PokemonListDataSource.swift
//  pokemon
//
//  Created by Márcio Duarte on 12/04/2022.
//

import Foundation
import UIKit

class PokemonListDataSource<CELL : UICollectionViewCell, T>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Private vars
    private var cellIdentifier: String!
    private var pokemons: [Pokemon]?
    private var isLoadingCell: Bool = false
    private var numberOfCellsVisible: Int = 0

    // MARK: - Public vars
    var configureCell: (CELL, Pokemon, Bool, Int) -> () = {_, _, _, _ in}
    var getMorePokemons:((Int) -> Void)? = nil
    var seeMoreWasClicked:((Int) -> Void)? = nil

    override init() {
        super.init()
    }

    init(WithCellIdentifier cellIdentifier: String, andPokemons pokemons: T, andIsLoadingCell isLoadingCell: Bool, andNumberOfCellsVisible numberOfCellsVisible: Int, andCellConfig cellConfig: @escaping (CELL, Any, Bool, Int) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.pokemons = pokemons as? [Pokemon]
        self.configureCell = cellConfig
        self.isLoadingCell = isLoadingCell
        self.numberOfCellsVisible = numberOfCellsVisible
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.pokemons?.count ?? 0) + 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as! CELL

        if (self.pokemons?.count ?? 0) - 1 >= indexPath.row {
            let pokemon = self.pokemons?[indexPath.row]

            self.configureCell(cell, pokemon!, false, self.numberOfCellsVisible)
        } else {
            let emptyPokemon: Pokemon = Pokemon(id: nil, name: nil, url: nil, weight: nil, height: nil, sprites: nil, types: nil, abilities: nil, stats: nil)
            self.configureCell(cell, emptyPokemon, true, self.numberOfCellsVisible)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Fetch more pokemons when 10 pokemons are missing to display
        if (self.pokemons?.count ?? 0) - 10 == indexPath.row  {
            self.getMorePokemons?((self.pokemons?.count ?? 0) + self.numberOfCellsVisible)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let pokemon = self.pokemons?[indexPath.row] {
            self.seeMoreWasClicked?(pokemon.id ?? 0)
        }
    }

}
