//
//  pokemonAPIServicesTests.swift
//  pokemonTests
//
//  Created by Márcio Duarte on 16/04/2022.
//

import XCTest

class pokemonAPIServicesTests: XCTestCase {

    var pokemonWebService = PokemonWebServices()
    var pokemonListView: PokemonListView = PokemonListView()
    var pokemonListViewModel: PokemonListViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.pokemonListViewModel = PokemonListViewModel(pokemonAPI: self.pokemonWebService)
        self.pokemonWebService = PokemonWebServices()
    }

    func testGetPokemons() {
        pokemonListViewModel.fetchPokemons()
        // Sleep 15 seconds because we need to wait for the service respnse
        sleep(15)
        XCTAssertTrue(pokemonListViewModel.pokemons.count > 0)
    }

    func testSearchPokemon() {
        self.pokemonListView.pokemonsSearchText = "-100"
        // Sleep 15 seconds because we need to wait for the service respnse
        sleep(10)
        XCTAssertFalse(self.pokemonListView.findPokemonOnSearch == false, "If the search is active, the flag findPokemonOnSearch must be set to true")
    }
}
