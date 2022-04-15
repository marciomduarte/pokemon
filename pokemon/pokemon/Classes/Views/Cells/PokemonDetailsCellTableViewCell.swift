//
//  PokemonDetailsCellTableViewCell.swift
//  pokemon
//
//  Created by Márcio Duarte on 15/04/2022.
//

import UIKit

class PokemonDetailsCellTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - Public vars
    static let identifier = "PokemonTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupUI()
    }

    private func setupUI() {
        self.titleLabel.pokemonDetailCellTitleStyle()
        self.descriptionLabel.pokemonDetailCellDescriptionStyle()
    }

    public func configCell(withPokemonDetails pokemonDetails: PokemonDetails) {
        self.titleLabel.text = pokemonDetails.detailsTitle
        self.descriptionLabel.text = pokemonDetails.detailsDescription
    }
    
}
