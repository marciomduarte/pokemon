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
    private var pokemons: PokemonList? {
        didSet {
            self.pokemonsListUpdateDataSource()
        }
    }
    private var pokemonsDataSource: PokemonListDataSource<PokemonCell, [Pokemon]>!

    // MARK: - Public vars

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    private func setupUI() {
        // Config collectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 0.0, right: 20)
        layout.itemSize = CGSize(width: 120.0, height: 100.0)
        self.pokemonCollectionView.collectionViewLayout = layout

        self.pokemonCollectionView.register(UINib.init(nibName: String(describing: PokemonCell.self), bundle: nil), forCellWithReuseIdentifier: PokemonCell.identifier)

        Task {
            self.pokemons = await PokemonWebServices.getPokemonList(withNewPage: 0)
        }
    }

    private func pokemonsListUpdateDataSource() {
        self.pokemonsDataSource = PokemonListDataSource(WithCellIdentifier: PokemonCell.identifier, andPokemons: self.pokemons!.results, andCellConfig: { (cell, item) in
            if let pokemon = item as? Pokemon {
                cell.pokemonNameLabel.text = pokemon.name
            }
        })

        self.pokemonCollectionView.dataSource = self.pokemonsDataSource
        self.pokemonCollectionView.reloadData()
    }
}
