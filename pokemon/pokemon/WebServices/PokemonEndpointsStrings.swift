//
//  PokemonEndpoints.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import Foundation

struct PokemonEndpoints {

    /// Endpoint base url
    static var baseUrl: String = "https://pokeapi.co/api/v2/"

    /// Create the url to get the list of pokemons
    /// - Parameters: Receive the limit and the offSet
    /// - Return created endpoint with the paramters receive.
    static func getListOfPokemons(withLimit limit: Int, andOffSet offSet: Int) -> String {
        let endpointString = baseUrl + "pokemon?offset=\(offSet)&limit=\(limit)"
        return endpointString
    }

    /// Create the url to get one specific elements/pokemon
    /// - Parameters: Receive pokemonIdOrName 
    /// - Receive pokemon Identifier or pokemonName. Can be either the name or the id.
    static func getPokemonById(withPokemonIdOrName pokemonIdOrName: String) -> String {
        let endpointString = baseUrl + "pokemon/\(pokemonIdOrName)"
        return endpointString
    }
}
