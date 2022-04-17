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
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

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

        self.pokemonNameLabel.accessibilityElementsHidden = true
        self.pokemonIdLabel.accessibilityElementsHidden = true
        self.pokemonTypeLabel.accessibilityElementsHidden = true
        self.titleLabel.accessibilityElementsHidden = true
        self.activityIndicator.accessibilityElementsHidden = true
    }

    override func prepareForReuse() {
        self.resetCell()
    }

    private func resetCell() {
        self.contentViewCell.backgroundColor = UIColor.pokemonCellBackgroundColor.withAlphaComponent(0.5)
        self.pokemonIdLabel.text = ""
        self.pokemonNameLabel.text = ""
        self.pokemonTypeLabel.text = ""
        self.pokemonImageView.image = nil
        self.activityIndicator.isHidden = true
    }

    public func configCell(withPokemon pokemon: Pokemon) {
        if let id = pokemon.id {
            self.pokemonIdLabel.text = "#\(String(describing: id))"
        }

        self.pokemonNameLabel.text = pokemon.name?.capitalized
        if let frontImageData = pokemon.sprites?.frontDefaultData {
            self.pokemonImageView.image = UIImage(data: frontImageData)
        }

        if let type: String = pokemon.types?.first?.type?.name {
            self.pokemonTypeLabel.text = type.capitalized
            self.contentViewCell.backgroundColor = UIColor.pokemonColorsDict[type]
        }

        self.contentViewCell.isAccessibilityElement = true
        self.contentViewCell.accessibilityLabel = String(format: NSLocalizedString("pokemon.accessibility.list.pokemon.resume", comment: ""), self.pokemonIdLabel.text!, self.pokemonNameLabel.text!, self.pokemonTypeLabel.text!)
    }

    public func configLoadingView() {
        self.resetCell()
        self.titleLabel.text = ""

        self.contentViewCell.backgroundColor = UIColor.pokemonListBackgroundColor

        self.activityIndicator.style = UIActivityIndicatorView.Style.large
        self.activityIndicator.color = UIColor.pokemonRedColor
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
}
