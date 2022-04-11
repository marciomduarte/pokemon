//
//  PokemonListViewController.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import UIKit

class PokemonListViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var pokemonCollectionView: UICollectionView!

    // MARK: - Private vars

    // MARK: - Public vars

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    private func setupUI() {

        // Config searchbar

        // Config collectionView

    }
}
