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

    static let paeanBlackColor = UIColor(red: 73, green: 66, blue: 72)

    static let pokemonTypeNormalColor = UIColor(red: 168, green: 167, blue: 122)

    static let pokemonTypeFireColor = UIColor(red:  238, green: 129, blue: 48)

    static let pokemonTypeWaterColor = UIColor(red:  99, green: 144, blue: 240)

    static let pokemonTypeElectricColor = UIColor(red: 247, green: 208, blue: 44)

    static let pokemonTypeGrassColor = UIColor(red: 122, green: 199, blue: 76)

    static let pokemonTypeIceColor = UIColor(red: 150, green: 217, blue: 214)

    static let pokemonTypeFightingColor = UIColor(red: 194, green: 46, blue: 40)

    static let pokemonTypePoisonColor = UIColor(red: 163, green: 62, blue: 161)

    static let pokemonTypeGroundColor = UIColor(red: 226, green: 191, blue: 101)

    static let pokemonTypeFlyingColor = UIColor(red: 169, green: 143, blue: 243)

    static let pokemonTypePsychicColor = UIColor(red: 249, green: 85, blue: 135)

    static let pokemonTypeBugColor = UIColor(red: 166, green: 185, blue: 26)

    static let pokemonTypeRockColor = UIColor(red: 182, green: 161, blue: 54)

    static let pokemonTypeGhostColor = UIColor(red: 115, green: 87, blue: 151)

    static let pokemonTypeDragonColor = UIColor(red: 111, green: 53, blue: 252)

    static let pokemonTypeDarkColor = UIColor(red: 112, green: 87, blue: 70)

    static let pokemonTypeSteelColor = UIColor(red: 183, green: 183, blue: 206)

    static let pokemonTypeFairyColor = UIColor(red: 214, green: 133, blue: 173)

    static let pokemonColorsDict: [String: UIColor] = ["normal": UIColor.pokemonTypeNormalColor,
                                                       "fire": UIColor.pokemonTypeFireColor,
                                                       "water": UIColor.pokemonTypeWaterColor,
                                                       "electric": UIColor.pokemonTypeElectricColor,
                                                       "grass": UIColor.pokemonTypeGrassColor,
                                                       "ice": UIColor.pokemonTypeIceColor,
                                                       "fighting": UIColor.pokemonTypeFightingColor,
                                                       "poison": UIColor.pokemonTypePoisonColor,
                                                       "ground": UIColor.pokemonTypeGroundColor,
                                                       "flying": UIColor.pokemonTypeFlyingColor,
                                                       "psychic": UIColor.pokemonTypePsychicColor,
                                                       "bug": UIColor.pokemonTypeBugColor,
                                                       "rock": UIColor.pokemonTypeRockColor,
                                                       "ghost": UIColor.pokemonTypeGhostColor,
                                                       "dragon": UIColor.pokemonTypeDragonColor,
                                                       "dark": UIColor.pokemonTypeDarkColor,
                                                       "steel": UIColor.pokemonTypeSteelColor,
                                                       "fairy": UIColor.pokemonTypeFairyColor]
}
