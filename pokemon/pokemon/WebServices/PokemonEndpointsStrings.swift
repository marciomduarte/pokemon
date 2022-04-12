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

    //getListOfPokemons
    static var listOfPokemons: String = "pokemon?limit=%@&offset=%@"

    static func getListOfPokemons(withLimit limit: Int, andOffSet offSet: Int) -> String {
        let endpointString = baseUrl + "pokemon?limit=\(limit)&offset=\(offSet)" //String(format: listOfPokemons, limit, offSet)
        return endpointString
    }
}
