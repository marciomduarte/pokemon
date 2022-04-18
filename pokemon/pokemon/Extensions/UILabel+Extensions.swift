//
//  UILabel+Extensions.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import Foundation
import UIKit

extension UILabel {

    public func pokemonListTitleLabelStyle() {
        self.font = UIFont.customRegularFont(withSize: 38)
        self.textColor = .black
    }

    // MARK: - Pokemon cell styles
    public func pokemonCellTypeLabelStyle() {
        self.font = UIFont.customItalicFont(withSize: 18)
        self.textColor = UIColor.pokemonListBackgroundColor
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

    public func pokemonCellNumberTitleLabelStyle() {
        self.font = UIFont.customItalicFont(withSize: 18)
        self.textColor = UIColor.pokemonListBackgroundColor
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

    public func pokemonCellNameTitleLabelStyle() {
        self.font = UIFont.customItalicFont(withSize: 18)
        self.textColor = UIColor.pokemonListBackgroundColor
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

    public func pokemonCellNameLabelStyle() {
        self.font = UIFont.customRegularFont(withSize: 20)
        self.textColor = UIColor.pokemonListBackgroundColor
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

    public func pokemonDetailPokemonLabelStyle() {
        self.font = UIFont.customItalicFont(withSize: 50)
        self.textColor = UIColor.white
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }

    public func pokemonListEmptyStateStyle() {
        self.font = UIFont.customRegularFont(withSize: 30)
        self.textColor = UIColor.pokemonRedColor.withAlphaComponent(0.6)
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }

    // MARK: - DetailsCell
    public func pokemonDetailCellTitleStyle() {
        self.font = UIFont.customItalicFont(withSize: 16)
        self.textColor = UIColor.paeanBlackColor.withAlphaComponent(0.6)
    }

    public func pokemonDetailCellDescriptionTitleStyle() {
        self.font = UIFont.customRegularFont(withSize: 18)
        self.textColor = UIColor.paeanBlackColor
            .withAlphaComponent(0.8)
    }

    public func pokemonDetailCellDescriptionStyle() {
        self.font = UIFont.customRegularFont(withSize: 18)
        self.textColor = UIColor.paeanBlackColor.withAlphaComponent(0.7)
            .withAlphaComponent(0.8)
    }

    public func pokemonDetailCellSubDescriptionStyle() {
        self.font = UIFont.customRegularFont(withSize: 16)
        self.textColor = UIColor.paeanBlackColor.withAlphaComponent(0.7)
    }
}
