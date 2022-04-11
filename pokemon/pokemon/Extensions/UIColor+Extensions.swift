//
//  UIColor+Extensions.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import UIKit

extension UIColor {

    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }

    //MARK: - Custom Colors
    static let navigationBarColor = UIColor(red: 236, green: 0, blue: 0)

}
