//
//  PokemonDetail.swift
//  pokemon
//
//  Created by Márcio Duarte on 15/04/2022.
//

import Foundation

struct PokemonDetails {
    var detailsTitle: String = ""
    var detailsDescription: String = ""

    init(withDetailsTitle detailsTitle: String, andDetailsDescriptions detailsDescriptions: String) {
        self.detailsTitle = detailsTitle
        self.detailsDescription = detailsDescriptions
    }
}
