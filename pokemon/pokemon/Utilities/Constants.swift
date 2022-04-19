//
//  Constants.swift
//  pokemon
//
//  Created by Márcio Duarte on 16/04/2022.
//

import Foundation
import UIKit

class Constants {
    // UITests
    /// Identifier to the segmented control. Can see the segmented control on the PokemonDetailsViewController
    let kSegmentedControlIdentifier: String = "destailsSegmentedControl"

    /// Identifier the empty View when the service doesn't return pokemons to present on collection view in PokemonListViewController.
    let kEmptyListPokemonIdentifier: String = "emptyListPokemon"

    /// Identifier the empty View when the service doesn't return pokemons to present on collection view in PokemonListViewController.
    let kDetailsBottomViewNameLabel: String = "detailsPokemonName"

    // Language default
    let kENLanguage: String = "en"
}
