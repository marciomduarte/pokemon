//
//  UIColor+Extensions.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import UIKit

extension UIColor {

    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    //MARK: - Custom Colors
    static let pokemonListBackgroundColor = UIColor(red: 250, green: 250, blue: 248)
    static let pokemonCellBackgroundColor = UIColor(red: 28, green: 178, blue: 188)
    static let pokemonRedColor = UIColor(red: 234, green: 29, blue: 37)
    static let paeanBlack = UIColor(red: 73, green: 66, blue: 72)

    static let pokemonColorsDict: [String: UIColor] = ["normal": UIColor(red: 168, green: 167, blue: 122),
                                                       "fire": UIColor(red:  238, green: 129, blue: 48),
                                                       "water": UIColor(red:  99, green: 144, blue: 240),
                                                       "electric": UIColor(red: 247, green: 208, blue: 44),
                                                       "grass": UIColor(red: 122, green: 199, blue: 76),
                                                       "ice": UIColor(red: 150, green: 217, blue: 214),
                                                       "fighting": UIColor(red: 194, green: 46, blue: 40),
                                                       "poison": UIColor(red: 163, green: 62, blue: 161),
                                                       "ground": UIColor(red: 226, green: 191, blue: 101),
                                                       "flying": UIColor(red: 169, green: 143, blue: 243),
                                                       "psychic": UIColor(red: 249, green: 85, blue: 135),
                                                       "bug": UIColor(red: 166, green: 185, blue: 26),
                                                       "rock": UIColor(red: 182, green: 161, blue: 54),
                                                       "ghost": UIColor(red: 115, green: 87, blue: 151),
                                                       "dragon": UIColor(red: 111, green: 53, blue: 252),
                                                       "dark": UIColor(red: 112, green: 87, blue: 70),
                                                       "steel": UIColor(red: 183, green: 183, blue: 206),
                                                       "fairy": UIColor(red: 214, green: 133, blue: 173)]
}
