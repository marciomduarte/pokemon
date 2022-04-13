//
//  Pokemon.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import Foundation

struct Pokemon: Decodable, Hashable {
    let id: Int?
    let name: String?
    let url: String?
    let weight: Int?
    let height: Int?
    let sprites: Sprites?
    let types: [Types]?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }

}

struct Sprites: Decodable {

    let front_default: String?
    let back_default: String?

}

struct Types: Decodable {

    let type: PokemonType?

}

struct PokemonType: Decodable {

    let name: String?

}
