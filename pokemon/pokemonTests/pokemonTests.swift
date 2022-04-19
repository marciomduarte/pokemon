//
//  pokemonTests.swift
//  pokemonTests
//
//  Created by Márcio Duarte on 11/04/2022.
//

import XCTest
@testable import pokemon

class pokemonTests: XCTestCase {

    // ViewModels
    var pokemonDetailsTopViewModel: PokemonDetailsTopViewModel = PokemonDetailsTopViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testGetAbilities() {
        let effectEntriesEn: EffectEntries = EffectEntries(effect: "Effect tests", language: Language(name: "en"), short_effect: "shor effect test")
        let effectEntriesDe: EffectEntries = EffectEntries(effect: "Effect tests", language: Language(name: "pt"), short_effect: "shor effect test")

        let ability: Ability = Ability(withName: "static", andUrl: nil, withEffectsEntries: [effectEntriesEn, effectEntriesDe])
        let abilities: Abilities = Abilities(withAbility: ability, andIsHidden: false, andIsAbilityFetched: false)

        let pokemon: Pokemon = Pokemon(id: 25, name: "pikachu", url: nil, weight: 60, height: 4, sprites: nil, types: nil, abilities: [abilities], stats: nil)

        self.pokemonDetailsTopViewModel.pokemon = pokemon
        self.pokemonDetailsTopViewModel.pokemonDetailSegmentedSelected = .Abilities
        self.pokemonDetailsTopViewModel.getAbilitiesDetails()
        self.pokemonDetailsTopViewModel.bindPokemonDetails = { pokemonDetails in

            XCTAssertNotNil(pokemonDetails, "Pokemon details cannot be nil")
            XCTAssertTrue(pokemonDetails.count >= 1, "Pokemon have at least 1 ability")
            XCTAssertTrue((pokemonDetails.first?.detailsDescription.count ?? 0) >= 0, "Pokemon should be have ability description")
        }
    }

    func testCheckIfTextWriteOnSearchIsNumber() {
        var text = "1234"
        XCTAssertTrue(PokemonsUtils().isNumber(withString: text) == true, "Text is a number and the method should be return true")

        text = "pikachu"
        XCTAssertTrue(PokemonsUtils().isNumber(withString: text) == false, "Text is not a number and the method should be return false")

        text = "Pikachu1234"
        XCTAssertTrue(PokemonsUtils().isNumber(withString: text) == false, "Text have numbers and letters and the method should be return false")
    }
}
