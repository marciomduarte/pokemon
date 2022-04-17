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
    /// - Parameters:
    /// - PokemonIdOrName: Receive the NumberOfElements and the offset
    /// - numberOfElements => number of next pokemons return | offSet => number of pokemons fetched
    /// - Return the Pokemon list and the next and the previous page.
    func getPokemonList(withNumberOfElements numberOfElements: Int, withOffSet offSet: Int) async throws -> PokemonList? {

        guard let url = URL(string: PokemonEndpoints.getListOfPokemons(withLimit: numberOfElements, andOffSet: offSet)) else {
            throw PokemonsError.GeneralError
        }

        let (data, _, serviceError) = try await PokemonWebServices.urlSession.data(from: url)
        if let urlError = serviceError as? URLError, urlError.code == .notConnectedToInternet {
            throw PokemonsError.ConnectionError
        } else if data == nil {
            throw PokemonsError.MissingData
        }

        var pokemonDecoded: PokemonList?
        do {
            pokemonDecoded = try JSONDecoder().decode(PokemonList.self, from: data ?? Data())
        } catch {
            throw PokemonsError.GeneralError
        }

        return pokemonDecoded
    }

    /// Get additional information of pokemon by urlString
    /// - Parameters:
    /// - PokemonIdOrName: Receive urlString to get additional information about pokemon.
    /// - Return an optional Pokemon object
    func getAdditionalInformation(withURLString urlString: String) async throws -> Pokemon? {

        guard let url = URL(string: urlString) ?? URL(string: "") else {
            throw PokemonsError.GeneralError
        }

        let (data, _, serviceError) = try await PokemonWebServices.urlSession.data(from: url)
        if let urlError = serviceError as? URLError, urlError.code == .notConnectedToInternet {
            throw PokemonsError.ConnectionError
        } else if data == nil {
            throw PokemonsError.MissingData
        }

        var pokemonDecoded: Pokemon?
        do {
            pokemonDecoded = try JSONDecoder().decode(Pokemon.self, from: data ?? Data())
        } catch {
            throw PokemonsError.GeneralError
        }

        return pokemonDecoded
    }

    /// Used to retrieve the pokemon searched.
    /// - Parameters:
    /// - PokemonIdOrName: Receive pokemon Identifier or pokemonName. Can be either the name or the id.
    /// - Return an optional Pokemon object
    func getSearchPokemon(withPokemonIdOrName pokemonIdOrName: String) async throws -> Pokemon? {

        guard let url = URL(string: PokemonEndpoints.getPokemonById(withPokemonIdOrName: String(pokemonIdOrName))) else {
            throw PokemonsError.GeneralError
        }

        let (data, _, serviceError) = try await PokemonWebServices.urlSession.data(from: url)
        if let urlError = serviceError as? URLError, urlError.code == .notConnectedToInternet {
            throw PokemonsError.ConnectionError
        } else if data == nil {
            throw PokemonsError.MissingData
        }

        var pokemonDecoded: Pokemon?
        do {
            pokemonDecoded = try JSONDecoder().decode(Pokemon.self, from: data ?? Data())
        } catch {
            throw PokemonsError.GetPokemonError
        }
        
        return pokemonDecoded
    }

    /// Get pokemon abilities
    /// - Parameters:
    /// - UrlString: Receive url string to go get the abilities
    /// - Return an optional Ability object
    func getPokemonAbilities(withURLString urlString: String) async throws -> Ability? {
        guard let url = URL(string: urlString) ?? URL(string: "") else {
            return nil
        }

        let (data, _, serviceError) = try await PokemonWebServices.urlSession.data(from: url)
        if let urlError = serviceError as? URLError, urlError.code == .notConnectedToInternet {
            throw PokemonsError.ConnectionError
        } else if data == nil {
            throw PokemonsError.MissingData
        }

        var abilityDecoded: Ability?
        do {
            abilityDecoded = try JSONDecoder().decode(Ability.self, from: data ?? Data())
        } catch {
            throw PokemonsError.GeneralError
        }

        return abilityDecoded
    }

    /// Get pokemon image data
    /// - Parameters:
    /// - UrlString: Receive an urlString to download the image data of pokemon
    /// - Return  an optional data
    func getImage(withURLString urlString: String) async throws -> Data? {
        guard let urlImage = URL(string: urlString) else {
            return nil
        }

        let (data, _, serviceError) = try await URLSession.shared.data(from: urlImage)
        if let urlError = serviceError as? URLError, urlError.code == .notConnectedToInternet {
            throw PokemonsError.ConnectionError
        } else if data == nil {
            throw PokemonsError.MissingData
        }

        return data
    }
}
