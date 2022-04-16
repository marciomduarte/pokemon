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
    func getSearchPokemon(withPokemonIdOrName pokemonIdOrName: String) async throws -> Pokemon?
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

        guard let (data, _) = try? await PokemonWebServices.urlSession.data(from: url) else {
            throw PokemonsError.MissingData
        }

        var pokemonDecoded: PokemonList?
        do {
            pokemonDecoded = try JSONDecoder().decode(PokemonList.self, from: data)
        } catch {
            throw PokemonsError.GeneralError
        }

        return pokemonDecoded
    }

    /// Get additional information of pokemon by urlString
    func getAdditionalInformation(withURLString urlString: String) async throws -> Pokemon? {

        guard let url = URL(string: urlString) ?? URL(string: "") else {
            throw PokemonsError.GeneralError
        }


        guard let (data, _) = try? await PokemonWebServices.urlSession.data(from: url) else {
            throw PokemonsError.MissingData
        }

        var pokemonDecoded: Pokemon?
        do {
            pokemonDecoded = try JSONDecoder().decode(Pokemon.self, from: data)
        } catch {
            throw PokemonsError.GeneralError
        }

        return pokemonDecoded
    }

    /// Get additional information of pokemon by id
    func getSearchPokemon(withPokemonIdOrName pokemonIdOrName: String) async throws -> Pokemon? {

        guard let url = URL(string: PokemonEndpoints.getPokemonById(withPokemonIdOrName: String(pokemonIdOrName))) else {
            throw PokemonsError.GeneralError
        }

        guard let (data, _) = try? await PokemonWebServices.urlSession.data(from: url) else {
            throw PokemonsError.MissingData
        }

        var pokemonDecoded: Pokemon?
        do {
            pokemonDecoded = try? JSONDecoder().decode(Pokemon.self, from: data)
        } catch {
            throw PokemonsError.GetPokemonError
        }
        
        return pokemonDecoded
    }

    /// Get pokemon abilities
    func getPokemonAbilities(withURLString urlString: String) async throws -> Ability? {
        guard let url = URL(string: urlString) ?? URL(string: "") else {
            return nil
        }

        guard let (data, _) = try? await PokemonWebServices.urlSession.data(from: url) else {
            throw PokemonsError.MissingData
        }

        var abilityDecoded: Ability?
        do {
            abilityDecoded = try JSONDecoder().decode(Ability.self, from: data)
        } catch {
            throw PokemonsError.GeneralError
        }

        return abilityDecoded
    }

    /// Get pokemon image data
    func getImage(withURLString urlString: String) async throws -> Data? {
        guard let urlImage = URL(string: urlString) else {
            return nil
        }

        guard let (data, _) = try? await URLSession.shared.data(from: urlImage) else {
            throw PokemonsError.MissingData
        }

        return data
    }
}
