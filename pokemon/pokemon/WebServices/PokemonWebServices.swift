//
//  PokemonWebServices.swift
//  pokemon
//
//  Created by Márcio Duarte on 11/04/2022.
//

import Foundation
import UIKit

protocol PokemonServiceProtocol {
    func getPokemonList(withNumberOfElements numberOfElements: Int, withOffSet offSet: Int) async throws -> PokemonList?
    func getAdditionalInformation(withURLString urlString: String) async throws -> Pokemon?
    func getAdditionalInformation(withPokemonId pokemonId: Int) async throws -> Pokemon?
    func getPokemonAbilities(withURLString urlString: String) async throws -> Ability?
    func getImage(withURLString urlString: String) async throws -> Data?
}

public class PokemonWebServices: PokemonServiceProtocol {
    static var urlSession = URLSession.shared

    /// Get list of pokemons
    func getPokemonList(withNumberOfElements numberOfElements: Int, withOffSet offSet: Int) async throws -> PokemonList? {

        guard let url = URL(string: PokemonEndpoints.getListOfPokemons(withLimit: numberOfElements, andOffSet: offSet)) else {
            throw PokemonsError.GeneralError
        }

        let (data, _) = try await PokemonWebServices.urlSession.data(from: url)

        var pokemonDecoded: PokemonList?
        do {
            pokemonDecoded = try JSONDecoder().decode(PokemonList.self, from: data)
        } catch {
            print(error)
        }

        return pokemonDecoded
    }

    /// Get additional information of pokemon by urlString
    func getAdditionalInformation(withURLString urlString: String) async throws -> Pokemon? {

        guard let url = URL(string: urlString) ?? URL(string: "") else {
            return nil
        }

        let (data, _) = try await PokemonWebServices.urlSession.data(from: url)

        return try JSONDecoder().decode(Pokemon.self, from: data)
    }

    /// Get additional information of pokemon by id
    func getAdditionalInformation(withPokemonId pokemonId: Int) async throws -> Pokemon? {

        guard let url = URL(string: PokemonEndpoints.getPokemonById(withPokemonId: pokemonId)) else {
            return nil
        }

        let (data, _) = try await PokemonWebServices.urlSession.data(from: url)

        return try JSONDecoder().decode(Pokemon.self, from: data)
    }

    /// Get pokemon abilities
    func getPokemonAbilities(withURLString urlString: String) async throws -> Ability? {
        guard let url = URL(string: urlString) ?? URL(string: "") else {
            return nil
        }

        let (data, _) = try await PokemonWebServices.urlSession.data(from: url)

        var abilityDecoded: Ability?
        do {
            abilityDecoded = try JSONDecoder().decode(Ability.self, from: data)
        } catch {
            print(error)
        }

        return abilityDecoded
    }

    /// Get pokemon image data
    func getImage(withURLString urlString: String) async throws -> Data? {
        guard let urlImage = URL(string: urlString) else {
            return nil
        }

        let (data, _) = try await URLSession.shared.data(from: urlImage)
        return data
    }
}
