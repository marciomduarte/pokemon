//
//  PokemonWebServices.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import Foundation
import UIKit

enum PokemonsError: Error {
    case InvalidURL
    case MissingData
}

struct PokemonWebServices {
    static let numberOfElementsInPage: Int = 120

    static var urlSession = URLSession.shared

    /// Get list of pokemons
    static func getPokemonList(withNewPage newPage: Int) async -> PokemonList? {

        guard let url = URL(string: PokemonEndpoints.getListOfPokemons(withLimit: numberOfElementsInPage, andOffSet: newPage)) else {
            return nil
        }

        let (data, _) = try! await urlSession.data(from: url)

        return try? JSONDecoder().decode(PokemonList.self, from: data)
    }

    // Get additional information of pokemon
    static func getAdditionalInformation(withURLString urlString: String) async -> Pokemon {

        let url = URL(string: urlString) ?? URL(string: "")
        let (data, _) = try! await urlSession.data(from: url!)

        return try! JSONDecoder().decode(Pokemon.self, from: data)
    }

    static func getImage(withURLString urlString: String) async -> Data? {
        guard let urlImage = URL(string: urlString) else {
            return nil
        }

        let (data, _) = try! await URLSession.shared.data(from: urlImage)
        return data
    }
}
