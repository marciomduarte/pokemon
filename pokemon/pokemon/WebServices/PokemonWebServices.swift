//
//  PokemonWebServices.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import Foundation

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

        return try! JSONDecoder().decode(PokemonList.self, from: data)
    }
}

extension URLSession {
    func data(from url: URL) async throws -> (Data, URLResponse){
        try await withCheckedContinuation({ continuation in
            self.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.unknown)
                    return continuation.resume(throwing: error as! Never)
                }

                continuation.resume(returning: (data, response))
            }.resume()
        })
    }
}
