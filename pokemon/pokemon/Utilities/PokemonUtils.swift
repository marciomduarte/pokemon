//
//  PokemonUtils.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import Foundation
import UIKit

// Enums
enum PokemonsError: Error {
    case MissingData
    case GeneralError
}


extension UIViewController {
    static var activityView: UIView?
    static var activityViewIndicator: UIActivityIndicatorView?

    func showActivityIndicator() {
        UIViewController.activityView = UIView(frame: UIScreen.main.bounds)
        UIViewController.activityView?.backgroundColor = UIColor.black
        UIViewController.activityView?.alpha = 0.3
        self.view.addSubview(UIViewController.activityView!)

        UIViewController.activityViewIndicator = UIActivityIndicatorView(style: .large)
        UIViewController.activityViewIndicator?.center = self.view.center
        UIViewController.activityViewIndicator?.color = UIColor.pokemonRedColor
        self.view.addSubview(UIViewController.activityViewIndicator!)
        UIViewController.activityViewIndicator?.startAnimating()
    }

    func hideActivityIndicator(){
        if UIViewController.activityViewIndicator != nil {
            UIViewController.activityViewIndicator?.stopAnimating()
            UIViewController.activityView?.removeFromSuperview()
        }
    }

    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return UIWindow.key!.rootViewController?.topMostViewController()
    }
}

extension UIWindow {
    static var key: UIWindow? {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    }
}
