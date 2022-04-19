//
//  PokemonListViewModel.swift
//  pokemon
//
//  Created by Márcio Duarte on 13/04/2022.
//
//  PokemonListViewView it's the view model to get all necessary information to present the list of pokemons
//  On this class we can found the methods to fetch pokemons and to fetch the pokemons searched by user

import UIKit

class PokemonListViewModel: NSObject {

    // MARK: - Private vars
    private(set) var pokemons: [Pokemon]! = [] {
        didSet {
            self.bindPokemonsList(self.pokemons)
        }
    }

    /// pokemonServiceAPI var used to call the protocol to data/informations
    private var pokemonServiceAPI: PokemonServiceProtocol

    /// Number of pokemons
    private var numberOfPokemonsFetched: Int = 0

    /// Offset of next pokemons
    private var offSet: Int = 0

    /// Offset of next pokemons
    private var isServiceAPIFetching: Bool = false

    // MARK: - Public vars
    /// Var with number of cell on screen
    var numberOfElementsOnScreen: Int? {
        willSet {
            self.numberOfPokemonsFetched = (newValue ?? 0) * 2
            self.fetchPokemons()
        }
    }

    /// Var used to send pokemons to view
    var bindPokemonsList: ((_ pokemons: [Pokemon]) -> ()) = {_ in}

    /// Var used to send searched pokemons to view
    var bindSearchedPokemons: ((_ pokemons: [Pokemon]) -> ()) = {_ in}

    // MARK: - Life Cycle
    /// Init Pokemon service api  protocol.
    init (pokemonAPI: PokemonServiceProtocol = PokemonWebServices()) {
        self.pokemonServiceAPI = pokemonAPI
    }

    /// Used to check if we have more pokemons
    public var hasNextPage: Bool = true

    /// Fetch pokemons
    public func fetchPokemons() {
        if !self.hasNextPage || self.isServiceAPIFetching {
            return
        }

        if self.pokemons.count == 0 {
            PokemonsUtils().showActivityView()
        }

        Task { [weak self] in
            guard let self = self else {
                return
            }

            self.isServiceAPIFetching = true

            do {
                let pokemonsList = try await self.pokemonServiceAPI.getPokemonList(withNumberOfElements: self.numberOfPokemonsFetched, withOffSet: self.offSet)

                let pokemonResult: [Pokemon] = pokemonsList?.results ?? []
                var newPokemons: [Pokemon] = []
                for var pokemonObject: Pokemon? in pokemonResult {
                    pokemonObject = try await self.pokemonServiceAPI.getAdditionalInformation(withURLString: pokemonObject?.url ?? "")
                    if var newPokemonObject: Pokemon = pokemonObject {
                        newPokemonObject = await PokemonsUtils().getPokemonImages(withPokemon: newPokemonObject)
                        newPokemons.append(newPokemonObject)
                    }
                }

                self.pokemons.append(contentsOf: newPokemons)

                NSLog("Result => Number of pokemons fetched => \(self.pokemons.count)")
                NSLog("Result => List of pokemons => \n \(self.pokemons.description)")

                self.offSet += (pokemonsList?.results.count ?? 0)
                self.hasNextPage = self.offSet < (pokemonsList?.count ?? 0)

                self.isServiceAPIFetching = false
            } catch {
                let errorData: [String: Error] = [errorType: error]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: PokemonErrorServiceNotification), object: errorData)
                self.isServiceAPIFetching = false
            }
        }
    }


    /// Function used to update collectionView
    /// Used to update collection when user click on cancel button on search bar
    public func getPokemonsToSearch(withSearchText searchText: String) {
        var searchPokemon: [Pokemon] = []

        PokemonsUtils().showActivityView()

        self.pokemons?.forEach({ pokemonFiltered in
            if PokemonsUtils().isNumber(withString: searchText), pokemonFiltered.id == Int(searchText) {
                searchPokemon.append(pokemonFiltered)
            } else if pokemonFiltered.name == searchText {
                searchPokemon.append(pokemonFiltered)
            }

            if searchPokemon.count > 0 {
            }
        })

        if (searchPokemon.isEmpty) {
            Task {
                do {
                    var newPokemon: Pokemon? = try await self.pokemonServiceAPI.getSearchPokemon(withPokemonIdOrName: searchText)

                    if (newPokemon != nil) {
                        let aux: Pokemon = await PokemonsUtils().getPokemonImages(withPokemon: newPokemon!)
                        newPokemon = aux
                        self.bindSearchedPokemons([newPokemon!])
                    } else {
                        self.bindSearchedPokemons([])
                        let errorData: [String: Error] = [errorType: PokemonsError.PokemonNoExist]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PokemonErrorServiceNotification), object: errorData)
                    }

                    PokemonsUtils().hideActivityView()
                } catch {
                    let errorData: [String: Error] = [errorType: error]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: PokemonErrorServiceNotification), object: errorData)
                }
            }
        } else {
            PokemonsUtils().hideActivityView()
        }

        self.bindSearchedPokemons(searchPokemon)
    }
}
