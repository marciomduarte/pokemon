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
        self.font = UIFont.customItalicFont(withSize: 16)
        self.textColor = .black
    }

    public func pokemonCellNumberTitleLabelStyle() {
        self.font = UIFont.customItalicFont(withSize: 16)
        self.textColor = .black
    }

    public func pokemonCellNameTitleLabelStyle() {
        self.font = UIFont.customItalicFont(withSize: 16)
        self.textColor = .black
    }

    public func pokemonCellNameLabelStyle() {
        self.font = UIFont.customRegularFont(withSize: 16)
        self.textColor = .black
    }
}
