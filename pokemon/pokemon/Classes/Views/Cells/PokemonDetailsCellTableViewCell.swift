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
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subDescriptionLabel: UILabel!

    // MARK: - Public vars
    static let identifier = "PokemonTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.descriptionTitleLabel.isHidden = true
        self.descriptionLabel.isHidden = true
        self.subDescriptionLabel.isHidden = true

    }

    private func setupUI() {
        self.titleLabel.pokemonDetailCellTitleStyle()
        self.descriptionTitleLabel.pokemonDetailCellDescriptionTitleStyle()
        self.descriptionLabel.pokemonDetailCellDescriptionStyle()
        self.subDescriptionLabel.pokemonDetailCellSubDescriptionStyle()
    }

    /// Method with configurations of the detail cell. This cell is used to configurate the detail tableView cell on DetailsViewControl when the user enter on the screen or change the segmented controll
    public func configCell(withPokemonDetails pokemonDetails: PokemonDetails) {

        self.titleLabel.text = pokemonDetails.detailsTitle

        if !pokemonDetails.detailsDescriptionTitle.isEmpty {
            self.descriptionTitleLabel.isHidden = false
            self.descriptionTitleLabel.text = pokemonDetails.detailsDescriptionTitle
        }

        if !pokemonDetails.detailsDescription.isEmpty {
            self.descriptionLabel.isHidden = false
            self.descriptionLabel.text = pokemonDetails.detailsDescription
        }

        if !pokemonDetails.detailsSubDescription.isEmpty {
            self.subDescriptionLabel.isHidden = false
            self.subDescriptionLabel.text = pokemonDetails.detailsSubDescription
        }
    }
    
}
