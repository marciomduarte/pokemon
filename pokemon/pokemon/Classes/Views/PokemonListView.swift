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
    private var pokemonEmptyListView: UIView = UIView()

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

    public var seeMorePokemonDetails : ((_ pokemonId: Int, _ pokemonList: [Pokemon]?) -> ()) = {_, _ in}

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

        // Add Pokemon empty list view
        self.getPokemonEmptyListView()
        self.pokemonCollectionView.addSubview(self.pokemonEmptyListView)

        self.pokemonListViewModel = PokemonListViewModel()
        self.pokemonListViewModel.numberOfElementsOnScreen = self.numberOfVisibelCell()
        self.pokemonListViewModel.bindPokemonsList = { pokemonsListFetched in
            self.pokemonsList = pokemonsListFetched
        }
    }

    // Populate PokemonCollectionView
    private func pokemonsListUpdateDataSource() {
        self.pokemonEmptyListView.isHidden = true

        UIApplication.shared.topMostViewController()?.hideActivityIndicator()

        if self.pokemonsList == nil || self.pokemonsList?.count == 0 {
            return
        }

        self.pokemonsDataSource = PokemonListDataSource(WithCellIdentifier: PokemonCell.identifier, andPokemons: self.pokemonsList!, andCellConfig: { (cell, item) in
            if let pokemon = item as? Pokemon {
//                if (item?.count ?? 0) == indexPath.row {
//                    // Display loading more pokemon cell
//                    cell.isUserInteractionEnabled = false
//                } else {
                    cell.configCell(withPokemon: pokemon)
//                }
            }
        })

        self.pokemonsDataSource.seeMoreWasClicked = { pokemonId in
            self.seeMorePokemonDetails(pokemonId, self.pokemonsList ?? [])
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

    /// Get collectionView empty view
    private func getPokemonEmptyListView() {
        let paddingTop: CGFloat = 8.0
        let imageViewWidth: CGFloat = 80.0
        let imageViewHeight: CGFloat = 80.0

        self.pokemonEmptyListView = UIView(frame: .zero)
        let xPos: CGFloat = (UIScreen.main.bounds.width / 2) - (imageViewWidth / 2)

        let imageView: UIImageView = UIImageView(frame: CGRect(x: xPos, y: self.pokemonCollectionView.frame.minY + imageViewWidth, width: imageViewWidth, height: imageViewHeight))
        imageView.image = UIImage(named: "outline_warning_black")
        imageView.tintColor = UIColor.pokemonRedColor
        self.pokemonEmptyListView.addSubview(imageView)

        let errorLabelWidth: CGFloat = UIScreen.main.bounds.width - (24 * 2)
        let errorLabel = UILabel(frame: CGRect(x: 24, y: imageView.frame.maxY + (paddingTop * 2), width: errorLabelWidth, height: 30.0))
        errorLabel.text = NSLocalizedString("pokemon.empty.list", comment: "")
        errorLabel.pokemonListEmptyStateStyle()
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.sizeToFit()

        var errorLabelFrame: CGRect = errorLabel.frame
        errorLabelFrame.size.width = errorLabelWidth;
        errorLabel.frame = errorLabelFrame

        self.pokemonEmptyListView.addSubview(errorLabel)

        var imageViewFrame: CGRect = self.pokemonEmptyListView.frame
        imageViewFrame.size.width = UIScreen.main.bounds.width
        imageViewFrame.size.height = imageViewWidth + (paddingTop * 2) + errorLabel.frame.height
        self.pokemonEmptyListView.frame = imageViewFrame
    }

    /// Create a Custom Flow layout
    /// Used to set pokemon list in grid
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
