//
//  Pokemon.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import Foundation

struct Pokemon: Decodable, Equatable, Identifiable {

    let id: Int?
    let name: String
    let url: String

}
