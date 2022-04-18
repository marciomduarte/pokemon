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
// Screen type to iphones with small screens
enum ScreenType: String {
    case iPhones_4_4S = "iPhone 4 or iPhone 4S"
    case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
    case unknown
}

/// Pokemons erros used to services error
enum PokemonsError: Error {
    case ConnectionError
    case MissingData
    case GeneralError
    case GetPokemonError
    case PokemonNoExist
    case NoMorePokemons
}

/// enum to identifier the index of segmented control
enum PokemonDetailSegmentedSelected: Int {
    case About
    case Abilities
    case Stats
}

/// Enum to identifier and return the title of cell
/// Segmented - About buttom
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
////// Segmented - Abilities details
enum PokemonAbilitiesDetail: String {
    case Ability

    var description: String {
        return NSLocalizedString("pokemon.cell.abilities", comment: "")
    }
}

/// PokemonUtils.
/// Class with common methods
class PokemonsUtils: NSObject {
    private var pokemonServiceAPI: PokemonServiceProtocol = PokemonWebServices()

    public func loadImage(withURLString urlString: String) async throws -> Data? {
        guard let imageData = try await self.pokemonServiceAPI.getImage(withURLString: urlString) else {
            return nil
        }

        return imageData
    }

    public func isNumber(withString string: String) -> Bool {
        return Double(string) != nil
    }

    /// Get Pokemon images (Front and back image)
    public func getPokemonImages(withPokemon pokemon: Pokemon) async -> Pokemon {
        var newPokemon = pokemon
        var frontPokemonImageData: Data? = nil
        var backPokemonImageData: Data? = nil

        if let frontImageUrl = pokemon.sprites?.front_default, let frontImageData: Data = try? await self.pokemonServiceAPI.getImage(withURLString: frontImageUrl) {
            frontPokemonImageData = frontImageData
        }

        if let backImageUrl = pokemon.sprites?.back_default, let backImageData: Data = try? await self.pokemonServiceAPI.getImage(withURLString: backImageUrl) {
            backPokemonImageData = backImageData
        }

        newPokemon.setFrontAndBackPokemonImage(withFrontImage: frontPokemonImageData, andBackImage: backPokemonImageData)

        return newPokemon
    }

    /// - Show activity view spinner
    public func showActivityView() {
        DispatchQueue.main.async {
            UIApplication.shared.topMostViewController()?.showActivityIndicator()
        }
    }

    /// - Hide activity view spinner
    public func hideActivityView() {
        DispatchQueue.main.async {
            UIApplication.shared.topMostViewController()?.hideActivityIndicator()
        }
    }
}

extension UIViewController {
    static var activityView: UIView?
    static var activityViewIndicator: UIActivityIndicatorView?

    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        default:
            return .unknown
        }
    }
    
    /// Method to set gesture recognizer to the view.
    /// This method is use to hide keyboard when view is tapped
    func hideKeyboardWhenTappedAround() {
        let tapOnScreen = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardHandler))
        tapOnScreen.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapOnScreen)
    }

    @objc func dismissKeyboardHandler() {
        self.view.endEditing(true)
    }

    /// Config  activity indicator
    func showActivityIndicator() {
        DispatchQueue.main.async {
            if self.view.subviews.contains(UIViewController.activityView ?? UIView()) {
                return
            }

            UIViewController.activityView = UIView(frame: UIScreen.main.bounds)
            UIViewController.activityView?.backgroundColor = UIColor.black
            UIViewController.activityView?.alpha = 0.3
            self.view.addSubview(UIViewController.activityView!)

            UIViewController.activityViewIndicator = UIActivityIndicatorView(style: .large)
            let minX: CGFloat = (UIScreen.main.bounds.width / 2)
            let minY: CGFloat = (UIScreen.main.bounds.height / 2) - ((UIViewController.activityViewIndicator?.frame.height ?? 0.0) / 3)
            UIViewController.activityViewIndicator?.center = CGPoint(x: minX, y: minY)
            UIViewController.activityViewIndicator?.color = UIColor.pokemonRedColor
            self.view.addSubview(UIViewController.activityViewIndicator!)
            UIViewController.activityViewIndicator?.startAnimating()
        }
    }

    /// remove activity indicator
    func hideActivityIndicator(){
        DispatchQueue.main.async {
            if UIViewController.activityView != nil {
                UIViewController.activityViewIndicator?.removeFromSuperview()
                UIViewController.activityView?.removeFromSuperview()
            }
        }
    }

    /// Method used to receive the notification sended when the app needs to call a service and this service return a error/problem.
    /// Also, this method create the message to show on alert.
    @objc func ErrorNotification(notification: NSNotification){
        DispatchQueue.main.async {
            self.topMostViewController().hideActivityIndicator()
            
            guard let object = notification.object as? [String: Any], let errorType: PokemonsError = object[errorType] as? PokemonsError else {
                return
            }

            NSLog("Receive error: \(errorType.localizedDescription)")
            var message: String = ""
            switch errorType {
            case .MissingData:
                message = NSLocalizedString("pokemon.alert.error.message.MissingData", comment: "")
            case .GetPokemonError:
                message = NSLocalizedString("pokemon.alert.error.message.error.find.pokemon", comment: "")
            case .PokemonNoExist:
                message = NSLocalizedString("pokemon.alert.error.message.cant.find.pokemon", comment: "")
            case .ConnectionError:
                message = NSLocalizedString("pokemon.alert.error.message.connection.error", comment: "")
            case .NoMorePokemons:
                message = NSLocalizedString("pokemon.alert.error.message.no.more.pokemons", comment: "")
            default:
                // General error
                message = NSLocalizedString("pokemon.alert.error.message.GeneralError", comment: "")
            }
            
            self.showErrorAlert(withMessage: message)
        }
    }

    /// Method to show the alert with de error or for the present information of the app
    func showErrorAlert(withMessage message: String) {
        let alert = UIAlertController(title: NSLocalizedString("pokemon.alert.error.title", comment: ""), message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("pokemon.alert.error.ok.button", comment: ""), style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    /// Get the ViewController on top of the list.
    /// Is used for the view controller, that is visualy on the top
    /// In this case, the topMostViewController it is used to show and hide the Activity View indicator
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

/// Get the ViewController on top of the list.
/// Is used for the view controller, that is visualy on the top
/// In this case, the topMostViewController it is used to show and hide the Activity View indicator
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
