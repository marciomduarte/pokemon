//
//  PokemonListViewController.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import UIKit

class PokemonListViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var pokemonCollectionView: UICollectionView!

    // MARK: - Private vars
    private var pokemonsDataSource: PokemonListDataSource<PokemonCell, [Pokemon]>!
    private var kCollectionPadding: CGFloat = 16.0
    private var kCollectionCellHeight: CGFloat = 120.0
    private var kCollectionCellMinWidth: CGFloat = 140.0
    private var kMinimunLineSpacing: CGFloat = 8.0
    private var kMinimumInteritemSpacing: CGFloat = 8.0

    // MARK: - Public vars
    public var pokemonsList: PokemonList?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    private func setupUI() {
        self.view.backgroundColor = UIColor.pokemonListBackGroundColor

        // Config collectionView
        self.pokemonCollectionView.backgroundColor = UIColor.clear
        self.pokemonCollectionView.collectionViewLayout = self.getFlowLayout()
        self.pokemonCollectionView.register(UINib.init(nibName: String(describing: PokemonCell.self), bundle: nil), forCellWithReuseIdentifier: PokemonCell.identifier)

        self.pokemonsListUpdateDataSource()
    }

    // Populate PokemonCollectionView with pokemon list
    private func pokemonsListUpdateDataSource() {
        if self.pokemonsList == nil || self.pokemonsList?.results.count == 0 {
            return
        }

        self.pokemonsDataSource = PokemonListDataSource(WithCellIdentifier: PokemonCell.identifier, andPokemons: self.pokemonsList!.results, andCellConfig: { (cell, item) in
            if let pokemon = item as? Pokemon {
                cell.configCell(withPokemon: pokemon)
            }
        })

        self.pokemonCollectionView.dataSource = self.pokemonsDataSource
        self.pokemonCollectionView.reloadData()
    }

    // Create CollectionFlowLayout
    private func getFlowLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: kCollectionPadding, left: kCollectionPadding, bottom: kCollectionPadding, right: kCollectionPadding)
        layout.minimumLineSpacing = kMinimunLineSpacing
        layout.minimumInteritemSpacing = kMinimumInteritemSpacing
        let collectionWidth: CGFloat = UIScreen.main.bounds.width - (kCollectionPadding * 2)
        let numberOfCellsInLine: CGFloat = (collectionWidth / kCollectionCellMinWidth).rounded(.down)
        let cellWidth: CGFloat = (collectionWidth - (kMinimumInteritemSpacing * numberOfCellsInLine)) / numberOfCellsInLine
        layout.itemSize = CGSize(width: cellWidth, height: kCollectionCellHeight)

        return layout
    }
}
