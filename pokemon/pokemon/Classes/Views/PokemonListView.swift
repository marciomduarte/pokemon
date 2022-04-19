//
//  PokemonListView.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//
//  PokemonListView is the UIView when the pokemons will be visible
//  This class receive the pokemon object and populate and construct the collectionViewDataSource

import Foundation
import UIKit

class PokemonListView: UIView {

    // MARK: - IBOutlets
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    @IBOutlet weak var contentView: UIView!

    // MARK: - Private vars
    ///Empty list view
    private var pokemonEmptyListView: UIView = UIView()

    /// View model control
    private var pokemonListViewModel: PokemonListViewModel!

    // MARK: - Public vars
    public var pokemonsDataSource: PokemonListDataSource<PokemonCell, [Pokemon]>!

    /// Var for list of pokemons
    /// When this var is setted, data source is called and start reload data of the collection
    public var pokemonsList: [Pokemon]? {
        didSet {
            DispatchQueue.main.async {
                self.pokemonsListUpdateDataSource()
                PokemonsUtils().hideActivityView()
            }
        }
    }

    /// Var for list of pokemons
    /// When this var is setted, data source is called and start reload data of the collection
    public var searchedListPokemons: [Pokemon]? {
        didSet {
            DispatchQueue.main.async {
                self.pokemonsListUpdateDataSource()
            }
        }
    }

    /// Var to control if the user is in search mode
    /// This var is setted to true when find an element on pokemon fetch or if the service call return values
    public var findPokemonOnSearch: Bool = false

    /// Text introduced by the user to get que pokemon ID or pokemon name.
    /// When this text is setted, the call the function to search on pokemonsArrays fetched or call the service to get the pokemon information
    public var pokemonsSearchText: String = "" {
        didSet {
            self.pokemonListViewModel.getPokemonsToSearch(withSearchText: self.pokemonsSearchText )
        }
    }

    /// Action to see more about the pokemon cell selected
    public var seeMorePokemonDetails : ((_ pokemonId: Int, _ pokemonList: [Pokemon]?) -> ()) = {_, _ in}

    // MARK: - Constants
    private var kCollectionPadding: CGFloat = 16.0
    private var kCollectionCellHeight: CGFloat = 120.0
    private var kCollectionCellMinWidth: CGFloat = 140.0
    private var kCollectionCellHeightIPad: CGFloat = 240.0
    private var kCollectionCellMinWidthIPad: CGFloat = 280.0
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

    /// Config Content view
    private func configContent() {
        Bundle.main.loadNibNamed(String(describing: PokemonListView.self), owner: self, options: nil)
        self.contentView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
        self.addSubview(self.contentView)

        self.setupUI()
    }

    /// Setup layout view
    private func setupUI() {
        // Config collectionView
        self.pokemonCollectionView.backgroundColor = UIColor.clear
        self.pokemonCollectionView.collectionViewLayout = self.getFlowLayout()
        self.pokemonCollectionView.register(UINib.init(nibName: String(describing: PokemonCell.self), bundle: nil), forCellWithReuseIdentifier: PokemonCell.identifier)
        self.pokemonCollectionView.accessibilityLabel = NSLocalizedString("pokemon.accessibility.list.pokemons", comment: "")

        // Add Pokemon empty list view
        self.getPokemonEmptyListView()
        self.pokemonCollectionView.addSubview(self.pokemonEmptyListView)

        self.pokemonListViewModel = PokemonListViewModel()
        self.pokemonListViewModel.numberOfElementsOnScreen = self.numberOfVisibelCell()

        //PokemonLisViewModel binds
        self.pokemonListViewModel.bindPokemonsList = { pokemonsListFetched in
            self.pokemonsList = pokemonsListFetched
        }

        self.pokemonListViewModel.bindSearchedPokemons = { searchPokemon in
            self.findPokemonOnSearch = true
            self.searchedListPokemons = searchPokemon
        }
    }

    // Populate PokemonCollectionView
    private func pokemonsListUpdateDataSource() {
        if self.pokemonsList == nil || self.pokemonsList?.count == 0 {
            return
        }

        self.pokemonsDataSource = PokemonListDataSource(WithCellIdentifier: PokemonCell.identifier, andPokemons: self.findPokemonOnSearch ? (self.searchedListPokemons ?? []) : self.pokemonsList!, andIsLoadingCell: self.pokemonListViewModel.hasNextPage, andIsSearchActive: self.findPokemonOnSearch, andCellConfig: { (cell, item, isLoadingCell, isSearchActive) in
            if let pokemon = item as? Pokemon {
                if isLoadingCell && !isSearchActive {
                    // Display loading more pokemon cell
                    cell.configLoadingView()
                } else {
                    // Display pokemon cell
                    cell.configCell(withPokemon: pokemon)
                }
            }
        })

        // PokemonDataSource binds
        self.pokemonsDataSource.seeMoreWasClicked = { pokemonId in
            self.seeMorePokemonDetails(pokemonId, self.findPokemonOnSearch ? self.searchedListPokemons ?? [] : self.pokemonsList ?? [])
        }

        // Configurated bind to get more pokemons. This bind listening to know when the collection view ask for more
        self.pokemonsDataSource.getMorePokemons = {
            self.pokemonListViewModel.fetchPokemons()
        }

        self.pokemonCollectionView.dataSource = self.pokemonsDataSource
        self.pokemonCollectionView.delegate = self.pokemonsDataSource
        self.pokemonCollectionView.reloadData()

        /// Hidden/show  emptyListView logic
        if let numberOfPokemonsFetched = self.pokemonsList?.count, numberOfPokemonsFetched > 0 && self.findPokemonOnSearch == false {
            self.pokemonEmptyListView.isHidden = true
        } else if let numberOfPokemonsFetched = self.searchedListPokemons?.count, numberOfPokemonsFetched > 0 {
            self.pokemonEmptyListView.isHidden = true
        } else {
            self.pokemonEmptyListView.isHidden = false
        }
    }

    /// Get number of cells the user can see.
    /// This method return all the cells, horizontal or vertical
    private func numberOfVisibelCell() -> Int {
        var cellDefaultHeight: CGFloat = kCollectionCellHeight
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            cellDefaultHeight = kCollectionCellHeightIPad
        }

        let collectionHeightWithoutPadding: CGFloat = self.frame.height - (kCollectionPadding * 2)
        let numberOfElements: CGFloat = (collectionHeightWithoutPadding / cellDefaultHeight).rounded(.down)

        return Int(numberOfElements) * self.numberOfHorizontalVisibelCell()
    }

    /// Get number of horizontal cell the user can
    private func numberOfHorizontalVisibelCell() -> Int {
        var cellDefaultWidth: CGFloat = kCollectionCellMinWidth
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            cellDefaultWidth = kCollectionCellMinWidthIPad
        }

        let collectionWidth: CGFloat = UIScreen.main.bounds.width - (kCollectionPadding * 2)
        let numberOfCellsInLine: CGFloat = (collectionWidth / cellDefaultWidth).rounded(.down)

        return Int(numberOfCellsInLine)
    }

    /// Get collectionView empty view
    private func getPokemonEmptyListView() {
        let paddingTop: CGFloat = 8.0
        let imageViewWidth: CGFloat = 80.0
        let imageViewHeight: CGFloat = 80.0

        self.pokemonEmptyListView = UIView(frame: .zero)
        self.pokemonEmptyListView.accessibilityIdentifier = Constants().kEmptyListPokemonIdentifier
        let xPos: CGFloat = (UIScreen.main.bounds.width / 2) - (imageViewWidth / 2)

        let imageView: UIImageView = UIImageView(frame: CGRect(x: xPos, y: self.pokemonCollectionView.frame.minY + imageViewWidth, width: imageViewWidth, height: imageViewHeight))
        imageView.image = UIImage(named: "outline_sync_problem_black")
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

        self.pokemonEmptyListView.isHidden = true
    }

    /// Create a Custom Flow layout
    /// Used to set pokemon list in grid
    private func getFlowLayout() -> UICollectionViewFlowLayout {
        var cellDefaultHeight: CGFloat = kCollectionCellHeight
        var cellDefaultWidth: CGFloat = kCollectionCellMinWidth
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            cellDefaultHeight = kCollectionCellHeightIPad
            cellDefaultWidth = kCollectionCellMinWidthIPad
        }

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: kCollectionPadding, left: kCollectionPadding, bottom: kCollectionPadding, right: kCollectionPadding)
        layout.minimumLineSpacing = kMinimunLineSpacing
        layout.minimumInteritemSpacing = kMinimumInteritemSpacing

        let collectionWidth: CGFloat = UIScreen.main.bounds.width - (kCollectionPadding * 2)
        let numberOfCellsInLine: CGFloat = (collectionWidth / cellDefaultWidth).rounded(.down)
        let cellWidth: CGFloat = (collectionWidth - (kMinimumInteritemSpacing * numberOfCellsInLine)) / numberOfCellsInLine
        layout.itemSize = CGSize(width: cellWidth, height: cellDefaultHeight)

        return layout
    }

    /// Function used to update collectionView
    /// Used to update collection when user click on cancel button on search bar
    public func reloadPokemonList() {
        self.searchedListPokemons = []
        self.findPokemonOnSearch = false
        self.pokemonsListUpdateDataSource()
    }
}
