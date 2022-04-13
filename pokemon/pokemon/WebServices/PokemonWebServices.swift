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
    static var urlSession = URLSession.shared

    /// Get list of pokemons
    static func getPokemonList(withNumberOfElements numberOfElements: Int, withOffSet offSet: Int) async throws -> PokemonList? {

        guard let url = URL(string: PokemonEndpoints.getListOfPokemons(withLimit: numberOfElements, andOffSet: offSet)) else {
            return nil
        }

        let (data, _) = try await urlSession.data(from: url)

        return try JSONDecoder().decode(PokemonList.self, from: data)
    }

    // Get additional information of pokemon by urlString
    static func getAdditionalInformation(withURLString urlString: String) async throws -> Pokemon? {

        guard let url = URL(string: urlString) ?? URL(string: "") else {
            return nil
        }

        let (data, _) = try await urlSession.data(from: url)

        return try JSONDecoder().decode(Pokemon.self, from: data)
    }

    // Get additional information of pokemon by id
    static func getAdditionalInformation(withPokemonId pokemonId: Int) async throws -> Pokemon? {

        guard let url = URL(string: PokemonEndpoints.getPokemonById(withPokemonId: pokemonId)) else {
            return nil
        }

        let (data, _) = try await urlSession.data(from: url)

        return try JSONDecoder().decode(Pokemon.self, from: data)
    }

    static func getImage(withURLString urlString: String) async -> Data? {
        guard let urlImage = URL(string: urlString) else {
            return nil
        }

        let (data, _) = try! await URLSession.shared.data(from: urlImage)
        return data
    }
}
