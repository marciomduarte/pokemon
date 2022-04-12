//
//  Pokemon.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import Foundation

struct Pokemon: Decodable {

    let id: Int?
    let name: String?
    let url: String?
    let weight: Int?
    let height: Int?
    let sprites: Sprites?
    let types: [Types]?

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
