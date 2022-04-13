//
//  UIViewExtensions.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import Foundation
import UIKit

extension UIView {

    public func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 8
    }

}
