//
//  PokemonDetailsTopView.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//
//  PokemonDetailsTopView is the UIView when the user can see the pokemon details (id, name, ..), abilities ans base stat

import UIKit

class PokemonDetailsTopView: UIView {

    // MARK: - IBOutlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var swipeInfoLabel: UILabel!

    // MARK: - Private vars
    /// Data source of table view details.
    /// User to create data source to show in details
    private var pokemonsDetailsDataSource: PokemonDetailsTopViewTableDataSource<PokemonDetailsCell, Any>!

    // MARK: - Public vars
    /// Set pokemon selected to show the details
    /// When pokemon is setted, automatically the pokemon is setted on viewModel to get all the details.
    public var pokemon: Pokemon! {
        didSet {
            if self.pokemonDetailsTopViewModel != nil {
                self.pokemonDetailsTopViewModel.pokemon = self.pokemon
                self.pokemonDetailsTopViewModel.pokemonDetailSegmentedSelected = .About
                DispatchQueue.main.async {
                    self.segmentedControl.selectedSegmentIndex = 0
                }
            }
        }
    }

    /// pokemonDetailsTopViewModel is used in comunication of View and ViewModel.
    public var pokemonDetailsTopViewModel: PokemonDetailsTopViewModel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configContent()
    }

    private func configContent() {
        Bundle.main.loadNibNamed(String(describing: PokemonDetailsTopView.self), owner: self, options: nil)
        self.contentView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
        self.addSubview(self.contentView)

        self.setupUI()
    }

    private func setupUI() {
        //Config TableView
        self.tableView.register(UINib.init(nibName: String(describing: PokemonDetailsCell.self), bundle: nil), forCellReuseIdentifier: PokemonDetailsCell.identifier)

        // Config segmented control
        self.segmentedControl.backgroundColor = UIColor.clear
        self.segmentedControl.tintColor = UIColor.pokemonRedColor
        self.segmentedControl.selectedSegmentTintColor = UIColor.pokemonListBackgroundColor
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.pokemonRedColor], for:.normal)

        let normalFontSegmentedControlFont: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.customItalicFont(withSize: 15.0) as Any]
        segmentedControl.setTitleTextAttributes(normalFontSegmentedControlFont, for: .normal)
        let selectedFontSegmentedControlFont: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.customItalicFont(withSize: 16.0) as Any, NSAttributedString.Key.foregroundColor : UIColor.pokemonRedColor]
        segmentedControl.setTitleTextAttributes(selectedFontSegmentedControlFont, for: .selected)

        self.segmentedControl.setTitle(NSLocalizedString("pokemon.details.about", comment: ""), forSegmentAt: 0)
        self.segmentedControl.setTitle(NSLocalizedString("pokemon.details.abilities", comment: ""), forSegmentAt: 1)
        self.segmentedControl.setTitle(NSLocalizedString("pokemon.details.stats", comment: ""), forSegmentAt: 2)
        self.segmentedControl.accessibilityIdentifier = Constants().kSegmentedControlIdentifier

        // Config PokemonDetailsViewModel
        self.pokemonDetailsTopViewModel = PokemonDetailsTopViewModel()
        self.pokemonDetailsTopViewModel.bindPokemonDetails = { details in
            self.updatePokemonsDetailsDataSource(withDetails: details)
        }

        // Config swipe info label
        self.swipeInfoLabel.text = NSLocalizedString("pokemon.details.swipe", comment: "")
        self.swipeInfoLabel.pokemonDetailCellTitleStyle()
    }

    /// Call updatePokemonDetails when PokemonDetailsViewModel return the pokemonDetailsObject
    private func updatePokemonsDetailsDataSource(withDetails details: [Any]) {
        self.pokemonsDetailsDataSource = PokemonDetailsTopViewTableDataSource(cellIdentifier: PokemonDetailsCell.identifier, pokemonDetails: details, startCellConfiguration: { cell, item in
            if let pokemonDetails = item as? PokemonDetails {
                cell.configCell(withPokemonDetails: pokemonDetails)
                cell.selectionStyle = .none
            }
        })

        self.tableView.dataSource = self.pokemonsDetailsDataSource
        self.tableView.delegate = self.pokemonsDetailsDataSource
        self.tableView.reloadData()
    }

    /// Action of the segmented controll.
    @IBAction func segmentedControlWasClicked(_ sender: Any) {
        if let segmentedControl = sender as? UISegmentedControl {
            self.pokemonDetailsTopViewModel.pokemonDetailSegmentedSelected = PokemonDetailSegmentedSelected.init(rawValue: segmentedControl.selectedSegmentIndex) ?? .About

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIAccessibility.post(notification: .screenChanged, argument: self.tableView);
            }
        }
    }

}
