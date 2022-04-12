//
//  PokemonCell.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import UIKit

class PokemonCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var contentViewCell: UIView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: PokemonImageView!

    // MARK: - Public vars
    static let identifier = "PokemonCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupUI()
    }

    private func setupUI() {
        self.contentViewCell.layer.cornerRadius = 16.0
        self.contentViewCell.backgroundColor = UIColor.pokemonCellBackgroundColor.withAlphaComponent(0.5)

        self.titleLabel.text = NSLocalizedString("pokemon.cell.name.label", comment: "")
        self.titleLabel.pokemonCellNameTitleLabelStyle()

        self.pokemonIdLabel.pokemonCellNumberTitleLabelStyle()
        self.pokemonTypeLabel.pokemonCellTypeLabelStyle()
        self.pokemonNameLabel.pokemonCellNameLabelStyle()
    }

    override func prepareForReuse() {
        self.contentViewCell.backgroundColor = UIColor.pokemonCellBackgroundColor.withAlphaComponent(0.5)
        self.pokemonIdLabel.text = ""
        self.pokemonNameLabel.text = ""
        self.pokemonImageView.image = nil
    }

    public func configCell(withPokemon pokemon: Pokemon) {
        if let id = pokemon.id {
            self.pokemonIdLabel.text = "#\(String(describing: id))"
        }

        self.pokemonNameLabel.text = pokemon.name?.capitalized
        self.pokemonImageView.loadImage(withURLString: pokemon.sprites?.front_default ?? "")
        if let type: String = pokemon.types?.first?.type?.name {
            self.pokemonTypeLabel.text = type.capitalized
            self.contentViewCell.backgroundColor = UIColor.pokemonColorsDict[type]
        }
    }
}
