//
//  PokemonImageView.swift
//  pokemon
//
//  Created by Márcio Duarte on 12/04/2022.
//

import Foundation
import UIKit

class PokemonImageView: UIImageView {

    private var pokemonServiceAPI: PokemonServiceProtocol = PokemonWebServices()

    func loadImage(withURLString urlString: String) {
        Task {
            if let imageData: Data = try await self.pokemonServiceAPI.getImage(withURLString: urlString) {
                self.image = UIImage(data: imageData)
            }
        }
    }
}

