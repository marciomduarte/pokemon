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
    var abilities: [Abilities]?
    let stats: [Stats]?

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

// MARK: - Abilities
struct Abilities: Decodable {
    var ability: Ability?
    var is_hidden: Bool?
    var isAbilityFetched: Bool? = false

    // Needs this init for the tests
    init(withAbility ability: Ability?, andIsHidden isHidden: Bool, andIsAbilityFetched isAbilityFetched: Bool) {
        self.ability = ability
        self.is_hidden = isHidden
        self.isAbilityFetched = isAbilityFetched
    }

    enum CodingKeys : String, CodingKey {
        case ability = "ability"
        case is_hidden = "is_hidden"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let ability = try? container.decodeIfPresent(Ability.self, forKey: .ability) {
            self.ability = ability
        }

        is_hidden = try container.decode(Bool.self, forKey: .is_hidden)
    }
    
}

struct Ability: Decodable {
    var name: String?
    var url: String?
    var effect_entries: [EffectEntries]?

    // Needs this init for the tests
    init(withName name: String?, andUrl url: String?, withEffectsEntries effectEntries: [EffectEntries]? ) {
        self.name = name
        self.url = url
        self.effect_entries = effectEntries
    }

    enum CodingKeys : String, CodingKey {
        case name = "name"
        case url = "url"
        case effectEntries = "effect_entries"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let name = try? container.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        }

        if let url = try? container.decodeIfPresent(String.self, forKey: .url) {
            self.url = url
        }

        if let effectEntries = try? container.decodeIfPresent([EffectEntries].self, forKey: .effectEntries) {
            self.effect_entries = effectEntries
        }
    }
}

struct EffectEntries: Decodable {
    var effect: String?
    var language: Language?
    var short_effect: String?
}

struct Language: Decodable {
    var name: String?
}

// MARK: - Pokemon Images
struct Sprites: Decodable {
    let front_default: String?
    var frontDefaultData: Data?
    let back_default: String?
    var backDefaultData: Data?
}

// MARK: - Types
struct Types: Decodable {
    let slot: Int
    let type: PokemonType?
}

struct PokemonType: Decodable {
    let name: String?
}

// MARK: - Pokemon Images
struct Stats: Decodable {
    let base_stat: Int?
    let stat: Stat?
}

struct Stat: Decodable {
    let name: String?
}
