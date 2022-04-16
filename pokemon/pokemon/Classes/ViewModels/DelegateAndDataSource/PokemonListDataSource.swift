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

    // MARK: - Public vars
    var configureCell: (CELL, Pokemon) -> () = {_,_ in}
    var getMorePokemons:((Int) -> Void)? = nil
    var seeMoreWasClicked:((Int) -> Void)? = nil

    override init() {
        super.init()
    }

    init(WithCellIdentifier cellIdentifier: String, andPokemons pokemons: T, andCellConfig cellConfig: @escaping (CELL, Any) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.pokemons = pokemons as? [Pokemon]
        self.configureCell = cellConfig
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemons?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as! CELL
        let pokemon = self.pokemons?[indexPath.row]

        self.configureCell(cell, pokemon!)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (self.pokemons?.count ?? 0) - 10 == indexPath.row - 1  {
            self.getMorePokemons?(indexPath.row + 1)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let pokemon = self.pokemons?[indexPath.row] {
            self.seeMoreWasClicked?(pokemon.id ?? 0)
        }
    }

}
