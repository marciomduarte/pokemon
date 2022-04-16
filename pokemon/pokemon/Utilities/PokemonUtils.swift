//
//  PokemonUtils.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import Foundation
import UIKit

// Dictionary keys
/// Used to get error type from notificatication object
let errorType: String = "errorType"

// Notification name
/// Used to send notification error
let PokemonErrorServiceNotification: String = "PokemonErrorServiceNotification"

// Enums
/// Pokemons erros used to services error or other type os errors
enum PokemonsError: Error {
    case MissingData
    case GeneralError
}

/// enum to identifier the index of segmented control
enum PokemonDetailSegmentedSelected: Int {
    case About
    case Abilities
    case Stats
}

/// Enum to identifier and return the title of cell
/// Used to About details
enum PokemonAboutDetailType: String {
    case IdType
    case NameType
    case PokemonType
    case WeightType
    case HeightType

    var description : String {
        switch self {
        case .IdType:
            return NSLocalizedString("pokemon.cell.about.number", comment: "")
        case .NameType:
            return NSLocalizedString("pokemon.cell.about.name", comment: "")
        case .PokemonType:
            return NSLocalizedString("pokemon.cell.about.pokemonType", comment: "")
        case .WeightType:
            return NSLocalizedString("pokemon.cell.about.weight", comment: "")
        case .HeightType:
            return NSLocalizedString("pokemon.cell.about.height", comment: "")
        }
    }
}

///// Enum to identifier and return the title of cell
///// Used to Abilities details
enum PokemonAbilitiesDetail: String {
    case Ability

    var description: String {
        switch self {
        case .Ability:
            return NSLocalizedString("pokemon.cell.abilities", comment: "")
        default:
            return ""
        }
    }
}

class PokemonsUtils: NSObject {
    private var pokemonServiceAPI: PokemonServiceProtocol = PokemonWebServices()

    func loadImage(withURLString urlString: String) async throws -> Data? {
        guard let imageData = try await self.pokemonServiceAPI.getImage(withURLString: urlString) else {
            return nil
        }

        return imageData
    }
}

extension UIViewController {
    static var activityView: UIView?
    static var activityViewIndicator: UIActivityIndicatorView?

    func hideKeyboardWhenTappedAround() {
        let tapOnScreen = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardHandler))
        tapOnScreen.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapOnScreen)
    }

    @objc func dismissKeyboardHandler() {
        self.view.endEditing(true)
    }

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

    @objc func methodOfReceivedNotification(notification: NSNotification){
        DispatchQueue.main.async {
            self.topMostViewController().hideActivityIndicator()
            
            guard let object = notification.object as? [String: Any], let errorType: PokemonsError = object[errorType] as? PokemonsError else {
                return
            }

            var message: String = ""
            switch errorType {
            case .MissingData:
                message = NSLocalizedString("pokemon.alert.error.message.MissingData", comment: "")
            default:
                // General error
                message = NSLocalizedString("pokemon.alert.error.message.GeneralError", comment: "")
            }
            self.showErrorAlert(withMessage: message)
        }
    }

    func showErrorAlert(withMessage message: String) {
        let alert = UIAlertController(title: NSLocalizedString("pokemon.alert.error.title", comment: ""), message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("pokemon.alert.error.ok.button", comment: ""), style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
