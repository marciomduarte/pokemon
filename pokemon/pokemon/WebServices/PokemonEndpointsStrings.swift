//
//  PokemonEndpoints.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import Foundation

struct PokemonEndpoints {

    //Endpoint
    static var baseUrl: String = "https://pokeapi.co/api/v2/"

    static func getListOfPokemons(withLimit limit: Int, andOffSet offSet: Int) -> String {
        let endpointString = baseUrl + "pokemon?offset=\(offSet)&limit=\(limit)"
        return endpointString
    }

    static func getPokemonById(withPokemonId pokemonId: Int) -> String {
        let endpointString = baseUrl + "pokemon/\(pokemonId)"
        return endpointString
    }
}
