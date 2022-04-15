//
//  PokemonDetailsBottomView.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//

import UIKit

class PokemonDetailsBottomView: UIView {

    // MARK: - IBOutlet
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imageViewContainer: UIView!
    @IBOutlet weak var pokemonView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!

    // MARK: - Private vars
    private var shownFrontPokemonVisivel: Bool = false

    // MARK: - Public vars
    public var pokemon: Pokemon! {
        didSet {
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configContent()
    }

    private func configContent() {
        Bundle.main.loadNibNamed(String(describing: PokemonDetailsBottomView.self), owner: self, options: nil)
        self.contentView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
        self.addSubview(self.contentView)
    }

    private func setupUI() {
        self.bottomView.layer.cornerRadius = self.bottomView.frame.height / 2
        self.imageViewContainer.layer.cornerRadius = self.imageViewContainer.frame.height / 2
        self.pokemonImageView.layer.cornerRadius = self.pokemonImageView.frame.height / 2
        self.pokemonView.layer.cornerRadius = self.pokemonView.frame.height / 2
        self.pokemonView.setShadow()

        if let frontImageData = self.pokemon.sprites?.frontDefaultData {
            self.pokemonImageView.image = UIImage(data: frontImageData)
        }
        self.imageViewContainer.backgroundColor = UIColor.white
        self.imageViewContainer.backgroundColor = UIColor.pokemonColorsDict[self.pokemon.types?.first?.type?.name ?? ""]
        self.bottomView.backgroundColor = UIColor.pokemonColorsDict[self.pokemon.types?.first?.type?.name ?? ""]

        self.pokemonNameLabel.pokemonDetailPokemonLabelStyle()
        self.pokemonNameLabel.text = pokemon.name?.capitalized

        // Add tap gesture recognizer to pokemon image to show front and back pokemon
        self.addPokemonGestureRecognizer()
    }

    private func addPokemonGestureRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.changeImageGesture(_:)))
        swipeRight.direction = .right
        self.imageViewContainer.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.changeImageGesture(_:)))
        swipeLeft.direction = .left
        self.imageViewContainer.addGestureRecognizer(swipeLeft)
    }

    @objc func changeImageGesture(_ sender: UIGestureRecognizer) {
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            var newPokemonImage: String = ""

            switch swipeGesture.direction {
            case .right:
                if shownFrontPokemonVisivel {
                    self.pokemonImageView.alpha = 0.0
                    newPokemonImage = self.pokemon.sprites?.front_default ?? ""
                    self.shownFrontPokemonVisivel = !self.shownFrontPokemonVisivel
                }
            case .left:
                if !shownFrontPokemonVisivel {
                    self.pokemonImageView.alpha = 0.0
                    newPokemonImage = self.pokemon.sprites?.back_default ?? ""

                    self.shownFrontPokemonVisivel = !self.shownFrontPokemonVisivel
                }
            default:
                break
            }

//            self.pokemonImageView.loadImage(withURLString: newPokemonImage)
            UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseInOut, animations: {
                self.pokemonImageView.alpha = 1.0
            }, completion: nil)
        }
    }
}
