//
//  PokemonDetail.swift
//  pokemon
//
//  Created by Márcio Duarte on 15/04/2022.
//

import Foundation

struct PokemonDetails {
    var detailsTitle: String = ""
    var detailsDescriptionTitle: String = ""
    var detailsDescription: String = ""
    var detailsSubDescription: String = ""

    init(withDetailsTitle detailsTitle: String, andDetailsDescriptionTitle detailsDescriptionTitle: String, andDetailsDescriptions detailsDescriptions: String, andDetailsSubDescription detailsSubDescription: String) {
        self.detailsTitle = detailsTitle
        self.detailsDescriptionTitle = detailsDescriptionTitle
        self.detailsDescription = detailsDescriptions
        self.detailsSubDescription = detailsSubDescription
    }
}
