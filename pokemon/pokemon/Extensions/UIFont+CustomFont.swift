//
//  UIFont+Extensions.swift
//  pokemon
//
//  Created by Márcio Duarte on 12/04/2022.
//

import Foundation
import UIKit

struct AppFontName {
  static let regular = "Ketchum"
  static let italic = "Ketchum-Italic"
}

extension UIFont {
    static func customRegularFont(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: AppFontName.regular, size: size)
    }

    static func customItalicFont(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: AppFontName.italic, size: size)
    }
}
