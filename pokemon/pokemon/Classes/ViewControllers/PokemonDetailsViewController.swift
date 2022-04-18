//
//  PokemonDetailsViewController.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var pokemonDetailsTopView: PokemonDetailsTopView!
    @IBOutlet weak var pokemonDetailsBottomView: PokemonDetailsBottomView!
    @IBOutlet weak var pokemonDetailsBottomViewHeightConstraint: NSLayoutConstraint!

    // MARK: - Private vars
    /// View model for pokemon details
    private var pokemonDetailsViewModel: PokemonDetailsViewModel!

    /// Pokemon selected by the user to see the details
    /// Pokemon sent by the view model to show details
    private var pokemon: Pokemon! {
        didSet {
            self.pokemonDetailsTopView.pokemon = self.pokemon
            self.pokemonDetailsBottomView.pokemon = self.pokemon
        }
    }

    // MARK: Public vars
    /// Pokemon identifier
    /// This pokemonId it is used to get more details to a specific pokemon
    /// The service call to get additional information use this
    public var pokemonId: Int = -1

    /// All pokemons fetched
    /// This array is used before calling the details service.
    /// It is an array to  check if the pokemon it is already loaded.
    public var pokemons: [Pokemon]!

    /// Save the swipe
    public var leftSwiped: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(PokemonErrorServiceNotification), object: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.pokemonRedColor
        self.navigationController?.navigationBar.topItem?.title = ""

        self.setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIAccessibility.post(notification: .announcement, argument: String(format: NSLocalizedString("pokemon.accessibility.pokemon.details", comment: ""), self.pokemon.name ?? "" ));
            self.pokemonDetailsBottomView.isAccessibilityElement = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(Notification.Name(PokemonErrorServiceNotification))
    }

    private func setupUI() {
        // Define backgroundColor
        self.view.backgroundColor = UIColor.pokemonListBackgroundColor

        self.pokemonDetailsViewModel = PokemonDetailsViewModel()
        self.getPokemonObject()

        // Bind to return pokemon to view controller
        self.pokemonDetailsViewModel.bindPokemonDetail = { pokemon in
            self.pokemon = pokemon
        }

        // Bind to return error if the pokemon doesn't exist
        self.pokemonDetailsViewModel.errorGetPokemon = {
            if self.leftSwiped {
                self.pokemonId -= 1
            } else {
                self.pokemonId += 1
            }
        }

        self.changeLayoutWhenUserChangeOrientation()
        self.addSwipeLeftRightToChangePokemon()
    }

    // Get pokemon object on PokemonsFetched array or call service to get a new one.
    private func getPokemonObject() {
        if let pokemonFetched = self.pokemons.first(where: { $0.id == self.pokemonId}) {
            self.pokemon = pokemonFetched
        } else {
            self.pokemonDetailsViewModel.pokemonId = self.pokemonId
        }
    }

    /// add gesture to swipe left right to call the next ou previou pokemon
    private func addSwipeLeftRightToChangePokemon() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.changeImageGesture(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.changeImageGesture(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }

    @objc func changeImageGesture(_ sender: UIGestureRecognizer) {
        PokemonsUtils().showActivityView()
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                self.leftSwiped = true
                if self.pokemonId > 1 {
                    self.pokemonId -= 1

                    self.getPokemonObject()
                }
                break
            case .left:
                self.leftSwiped = true
                self.pokemonId += 1
                self.getPokemonObject()
            default:
                break
            }
        }
    }

    // Change layout if device rotate
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.changeLayoutWhenUserChangeOrientation()
    }

    // Method to update layout after user change the device orientation
    private func changeLayoutWhenUserChangeOrientation() {
        if UIDevice.current.orientation.isLandscape {
            self.pokemonDetailsBottomViewHeightConstraint.constant = 0.0
            self.pokemonDetailsBottomView.isHidden = true
        } else {
            self.pokemonDetailsBottomViewHeightConstraint.constant = pokemonDetailsBottomView.bottomView.frame.maxY - self.pokemonDetailsBottomView.imageViewContainer.frame.minY
            self.pokemonDetailsBottomView.isHidden = false
        }
    }

}
