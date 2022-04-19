//
//  pokemonAPIServicesTests.swift
//  pokemonTests
//
//  Created by Márcio Duarte on 16/04/2022.
//

import XCTest

class pokemonAPIServicesTests: XCTestCase {

    let emptyPokemon: Pokemon = Pokemon(id: nil, name: nil, url: nil, weight: nil, height: nil, sprites: nil, types: nil, abilities: nil, stats: nil)

    var pokemonWebService: PokemonServiceProtocol = PokemonWebServices()

    // Views
    var pokemonListView: PokemonListView = PokemonListView()

    // ViewModels
    var pokemonListViewModel: PokemonListViewModel = PokemonListViewModel()
    var pokemonDetailsViewModel: PokemonDetailsViewModel = PokemonDetailsViewModel()
    var pokemonDetailsTopViewModel: PokemonDetailsTopViewModel = PokemonDetailsTopViewModel()

    // ViewController
    var pokemonDetailsViewController: PokemonDetailsViewController = PokemonDetailsViewController()

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

    func testSearchPokemonById() {
        self.pokemonListView.pokemonsSearchText = "-100"
        XCTAssertFalse(self.pokemonListView.findPokemonOnSearch == false, "If the search is active, the flag findPokemonOnSearch must be set to true")

        // search by Id
        let expectPokemonId = expectation(description: "Get pokemon with id 10")
        self.pokemonListViewModel.getPokemonsToSearch(withSearchText: "10")
        self.pokemonListViewModel.bindSearchedPokemons = { pokemons in
            expectPokemonId.fulfill()

            XCTAssertTrue(pokemons.count == 1, "Pokemons return only one pokemon")
            let pokemon: Pokemon = pokemons.first ?? self.emptyPokemon
            XCTAssertNotNil(pokemon, "Pokemon cannot by nil")
            XCTAssertTrue(pokemon.id == 10, "The pokemon retrived is the number 10")
            XCTAssertFalse(pokemon.name != "caterpie", "The pokemon number 10 is: caterpie")
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testSearchPokemonByName() {
        // search by Id
        let expectPokemonName = expectation(description: "Get pokemon with name pikachu")
        self.pokemonListViewModel.getPokemonsToSearch(withSearchText: "pikachu")
        self.pokemonListViewModel.bindSearchedPokemons = { pokemons in
            expectPokemonName.fulfill()

            let pokemon: Pokemon = pokemons.first ?? self.emptyPokemon
            XCTAssertFalse(pokemon.id == 10, "The pokemon retrived ")
            XCTAssertTrue(pokemon.name == "pikachu", "The pokemon name should be: Pikachu")
            XCTAssertNoThrow(pokemon)
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testGetAbilitiesWithGeneralError() async {
        do {
            _ = try await self.pokemonWebService.getPokemonAbilities(withURLString: "test_Test_test")
        } catch {
            XCTAssertTrue((error as? PokemonsError) == PokemonsError.GeneralError, "")
        }
    }

    func testMissingDataError() async {
        do {
            _ = try await self.pokemonWebService.getPokemonAbilities(withURLString: "https://pokeapi.co/api")
        } catch {
            XCTAssertTrue((error as? PokemonsError) != PokemonsError.MissingData, "")
        }
    }
}
