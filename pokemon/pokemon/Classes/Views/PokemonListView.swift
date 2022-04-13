//
//  PokemonListView.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import Foundation
import UIKit

class PokemonListView: UIView {

    // MARK: - IBOutlets
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    @IBOutlet var contentView: UIView!

    // MARK: - Private vars
    private var pokemonListViewModel: PokemonListViewModel!

    // MARK: - Public vars
    public var pokemonsDataSource: PokemonListDataSource<PokemonCell, [Pokemon]>!
    public var pokemonsList: [Pokemon]? {
        didSet {
            DispatchQueue.main.async {
                self.pokemonsListUpdateDataSource()
            }
        }
    }
    public var seeMorePokemonDetails : ((_ pokemonId: Int) -> ()) = {_ in}

    // MARK: - Constants
    private var kCollectionPadding: CGFloat = 16.0
    private var kCollectionCellHeight: CGFloat = 120.0
    private var kCollectionCellMinWidth: CGFloat = 140.0
    private var kMinimunLineSpacing: CGFloat = 8.0
    private var kMinimumInteritemSpacing: CGFloat = 8.0

    //MARK: - Life cycles
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configContent()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configContent()
    }

    private func configContent() {
        Bundle.main.loadNibNamed(String(describing: PokemonListView.self), owner: self, options: nil)
        self.contentView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
        self.addSubview(self.contentView)

        self.setupUI()
    }

    private func setupUI() {
        // Config collectionView
        self.pokemonCollectionView.backgroundColor = UIColor.clear
        self.pokemonCollectionView.collectionViewLayout = self.getFlowLayout()
        self.pokemonCollectionView.register(UINib.init(nibName: String(describing: PokemonCell.self), bundle: nil), forCellWithReuseIdentifier: PokemonCell.identifier)

        self.pokemonListViewModel = PokemonListViewModel()
        self.pokemonListViewModel.numberOfElementsOnScreen = self.numberOfVisibelCell()
        self.pokemonListViewModel.bindPokemonsList = { pokemonsListFetched in
            self.pokemonsList = pokemonsListFetched
        }
    }

    // Populate PokemonCollectionView
    private func pokemonsListUpdateDataSource() {
        if self.pokemonsList == nil || self.pokemonsList?.count == 0 {
            return
        }

        self.pokemonsDataSource = PokemonListDataSource(WithCellIdentifier: PokemonCell.identifier, andPokemons: self.pokemonsList!, andCellConfig: { (cell, item) in
            if let pokemon = item as? Pokemon {
                cell.configCell(withPokemon: pokemon)
            }
        })

        self.pokemonsDataSource.seeMoreWasClicked = { pokemonId in
            self.seeMorePokemonDetails(pokemonId)
        }

        self.pokemonsDataSource.getMorePokemons = { offSet in
            self.pokemonListViewModel.getPokemonList(withOffSet: offSet)
        }

        self.pokemonCollectionView.dataSource = self.pokemonsDataSource
        self.pokemonCollectionView.delegate = self.pokemonsDataSource
        self.pokemonCollectionView.reloadData()
    }

    private func numberOfVisibelCell() -> Int {
        let collectionHeightWithoutPadding: CGFloat = self.frame.height - (kCollectionPadding * 2)
        let numberOfElements: CGFloat = (collectionHeightWithoutPadding / kCollectionCellHeight).rounded(.down)

        return Int(numberOfElements) * 2
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
