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
    private var pokemonListViewModel: PokemonDetailsViewModel!
    private var pokemon: Pokemon! {
        didSet {
            self.pokemonDetailsTopView.pokemon = self.pokemon
            self.pokemonDetailsBottomView.pokemon = self.pokemon
        }
    }

    // MARK: Public vars
    public var pokemonId: Int = -1
    public var pokemons: [Pokemon]!

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

        self.pokemonListViewModel = PokemonDetailsViewModel()
        self.getPokemonObject()

        self.pokemonListViewModel.bindPokemonDetail = { pokemon in
            self.pokemon = pokemon
        }

        self.changeLayoutWhenUserChangeOrientation()
        self.addSwipeLeftRightToChangePokemon()
    }

    // Get pokemon object on PokemonsFetched array or call service to get a new one.
    private func getPokemonObject() {
        if let pokemonFetched = self.pokemons.first(where: { $0.id == self.pokemonId}) {
            self.pokemon = pokemonFetched
        } else {
            self.pokemonListViewModel.pokemonId = self.pokemonId
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
                if self.pokemonId > 1 {
                    self.pokemonId -= 1

                    self.getPokemonObject()
                }
                break
            case .left:
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
