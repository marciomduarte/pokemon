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
    var sprites: Sprites?
    let types: [Types]?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }

    mutating func setFrontAndBackPokemonImage(withFrontImage frontImage: Data?, andBackImage backImage: Data?) {
        self.sprites?.frontDefaultData = frontImage ?? nil
        self.sprites?.backDefaultData = backImage ?? nil
    }
}

struct Sprites: Decodable {

    let front_default: String?
    var frontDefaultData: Data?
    let back_default: String?
    var backDefaultData: Data?
}

struct Types: Decodable {
    var slot: Int
    let type: PokemonType?
}

struct PokemonType: Decodable {
    let name: String?
}
