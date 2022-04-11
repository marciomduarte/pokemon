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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupUI()
    }

    private func setupUI() {
        self.contentViewCell.layer.cornerRadius = 2.0
        self.titleLabel.text = "Name"
    }

    public func configPokemon(withPokemon pokemon: Pokemon) {
        self.pokemonIdLabel.text = "#\(pokemon.id)"
        self.pokemonNameLabel.text = pokemon.name
    }

    override func prepareForReuse() {
        self.pokemonIdLabel.text = ""
        self.pokemonNameLabel.text = ""
        self.pokemonImageView.image = nil
    }
}
