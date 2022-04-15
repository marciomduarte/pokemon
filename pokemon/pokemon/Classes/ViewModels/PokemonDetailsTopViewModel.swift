//
//  PokemonDetailsTopViewModel.swift
//  pokemon
//
//  Created by Márcio Duarte on 15/04/2022.
//

import Foundation

class PokemonDetailsTopViewModel: NSObject {

    // MARK: - Private vars
    static var kAppLanguageDefault: String = "en"

    private(set) var pokemonDetails: [PokemonDetails]! {
        didSet {
            DispatchQueue.main.async {
                self.bindPokemonDetails(self.pokemonDetails)
            }
        }
    }

    /// Used to comunicate with service protocol to call services.
    private var pokemonServiceAPI: PokemonServiceProtocol


    // MARK: - Public vars
    /// Bind to inform View to update details tableview
    var bindPokemonDetails: (([PokemonDetails]) -> ()) = {_ in}

    /// Pokemon selected to show details
    public var pokemon: Pokemon!

    public var pokemonDetailSegmentedSelected: PokemonDetailSegmentedSelected = .About {
        didSet {
            self.getPokemonAdditionalInformation()
        }
    }

    // MARK: - Life Cycles
    init (pokemonAPI: PokemonServiceProtocol = PokemonWebServices()) {
        self.pokemonServiceAPI = pokemonAPI
    }

    private func getPokemonAdditionalInformation() {
        Task {
            if let abilities = self.pokemon.abilities {
                var index: Int = 0
                for ability in abilities {
                    if let urlString = ability.ability?.url {
                        let newAbility = try await self.pokemonServiceAPI.getPokemonAbilities(withURLString: urlString)
                        self.pokemon.abilities?[index].ability = newAbility
                    }
                    index += 1
                }
                self.getPokemonDetails()
            }
        }
    }

    private func getPokemonDetails() {
        switch self.pokemonDetailSegmentedSelected {
        case .Abilities:
            self.getAbilitiesDetails()
        case .Stats:
            self.getStatsDetails()
        default:
            self.getAbountDetails()
        }
    }

    private func getAbountDetails() {
        var pokemonDetails: [PokemonDetails] = []

        // Cell Id
        pokemonDetails.append(PokemonDetails(withDetailsTitle: PokemonAboutDetailType.IdType.description, andDetailsDescriptions: String(describing: self.pokemon.id!)))

        // Cell Name
        pokemonDetails.append(PokemonDetails(withDetailsTitle: PokemonAboutDetailType.NameType.description, andDetailsDescriptions: self.pokemon.name?.capitalized ?? "-"))

        // Cell PokemonType
        var typeString: String = ""

        for type in self.pokemon.types ?? [] {
            typeString += (type.type?.name?.capitalized ?? "")
            if self.pokemon.types?.last?.type?.name != type.type?.name {
                typeString += "\n"
            }
        }
        pokemonDetails.append(PokemonDetails(withDetailsTitle: PokemonAboutDetailType.PokemonType.description, andDetailsDescriptions: typeString))

        // Cell Weight
        pokemonDetails.append(PokemonDetails(withDetailsTitle: PokemonAboutDetailType.WeightType.description, andDetailsDescriptions: "\(String(describing: self.pokemon.weight!)) kg"))

        // Cell Height
        pokemonDetails.append(PokemonDetails(withDetailsTitle: PokemonAboutDetailType.HeightType.description, andDetailsDescriptions: "\(String(describing: self.pokemon.height!)) cm"))

        self.pokemonDetails = pokemonDetails
    }

    private func getAbilitiesDetails() {
        var pokemonDetails: [PokemonDetails] = []

        self.pokemon.abilities?.forEach({ ability in
            if let hidden = ability.is_hidden, !hidden {
                // Cell Name
                pokemonDetails.append(PokemonDetails(withDetailsTitle: PokemonAboutDetailType.IdType.description, andDetailsDescriptions: ability.ability?.name ?? "-"))

                // Cell
                pokemonDetails.append(PokemonDetails(withDetailsTitle: PokemonAboutDetailType.IdType.description, andDetailsDescriptions: String(describing: self.pokemon.id!)))
            }
        })

        self.pokemonDetails = pokemonDetails
    }

    private func getStatsDetails() {
        var pokemonDetails: [PokemonDetails] = []

        self.pokemon.stats?.forEach({ stats in
            let statName = stats.stat?.name?.capitalized
            let baseState = String(describing: stats.base_stat!)

            // Cell Speed
            pokemonDetails.append(PokemonDetails(withDetailsTitle: statName ?? "-", andDetailsDescriptions: baseState))
        })

        self.pokemonDetails = pokemonDetails
    }
}
