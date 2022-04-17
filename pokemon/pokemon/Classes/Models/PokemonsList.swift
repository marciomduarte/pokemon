//
//  PokemonsList.swift
//  pokemon
//
//  Created by Márcio Duarte on 12/04/2022.
//

import Foundation

struct PokemonList: Decodable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Pokemon]
}
