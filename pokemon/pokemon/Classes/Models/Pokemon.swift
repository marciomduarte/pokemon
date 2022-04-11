//
//  Pokemon.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import Foundation


class Pokemon: Codable {

    var id: Int
    var name: String

    init(withId id: Int, andName name: String) {
        self.id = id
        self.name = name
    }
}
