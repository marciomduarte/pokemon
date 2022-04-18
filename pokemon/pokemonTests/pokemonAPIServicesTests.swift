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
        let expect = expectation(description: "Fetch pokemons")

        self.pokemonListViewModel.fetchPokemons()
        self.pokemonListViewModel.bindPokemonsList = { pokemons in
            expect.fulfill()

            XCTAssertTrue(pokemons.count > 0)
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testSearchPokemon() {
        self.pokemonListView.pokemonsSearchText = "-100"
        XCTAssertFalse(self.pokemonListView.findPokemonOnSearch == false, "If the search is active, the flag findPokemonOnSearch must be set to true")
    }
}
