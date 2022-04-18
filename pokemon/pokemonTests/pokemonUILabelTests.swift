//
//  pokemonUILabelTests.swift
//  pokemonTests
//
//  Created by Márcio Duarte on 16/04/2022.
//

import XCTest

class pokemonUILabelTests: pokemonTests {

    func testPokemonListTitleLabelStyle() {
        let label = UILabel()
        label.text = "New test"
        label.pokemonListTitleLabelStyle()

        XCTAssertEqual(label.font, UIFont.customRegularFont(withSize: 38), "Font should be of size: 38")
        XCTAssertEqual(label.textColor, UIColor.black, "Text color should be Black")
    }

    // MARK: - Pokemon cell styles
    func testPokemonCellTypeLabelStyle() {
        let label = UILabel()
        label.text = "New test"
        label.pokemonCellTypeLabelStyle()

        XCTAssertEqual(label.font, UIFont.customItalicFont(withSize: 18), "Font should be of size: 18")
        XCTAssertEqual(label.textColor, UIColor.pokemonListBackgroundColor, "Text color should be Black")
        XCTAssertTrue(label.shadowOffset == CGSize(width: 1.0, height: 1.0), "CGSize should be equal to CGSize(width: 1.0, height: 1.0)")
    }

    func testPokemonCellNumberTitleLabelStyle() {
        let label = UILabel()
        label.text = "New test"
        label.pokemonCellNumberTitleLabelStyle()

        XCTAssertEqual(label.font, UIFont.customItalicFont(withSize: 18), "Font should be of size: 18")
        XCTAssertEqual(label.textColor, UIColor.pokemonListBackgroundColor, "Text color should be pokemonListBackgroundColor")
        XCTAssertTrue(label.shadowOffset == CGSize(width: 1.0, height: 1.0), "CGSize should be equal to CGSize(width: 1.0, height: 1.0)")
        XCTAssertTrue(label.shadowColor == UIColor.black, "ShadowColor should be equal to black")
    }

    func testPokemonCellNameTitleLabelStyle() {
        let label = UILabel()
        label.text = "New test"
        label.pokemonCellNameTitleLabelStyle()

        XCTAssertEqual(label.font, UIFont.customItalicFont(withSize: 18), "Font should be of size: 18")
        XCTAssertEqual(label.textColor, UIColor.pokemonListBackgroundColor, "Text color should be pokemonListBackgroundColor")
        XCTAssertTrue(label.shadowOffset == CGSize(width: 1.0, height: 1.0), "CGSize should be equal to CGSize(width: 1.0, height: 1.0)")
        XCTAssertTrue(label.shadowColor == UIColor.black, "ShadowColor should be equal to black")
    }


    func testPokemonCellNameLabelStyle() {
        let label = UILabel()
        label.text = "New test"
        label.pokemonCellNameLabelStyle()

        XCTAssertEqual(label.font, UIFont.customRegularFont(withSize: 20), "Font should be of size: 20")
        XCTAssertEqual(label.textColor, UIColor.pokemonListBackgroundColor, "Text color should be pokemonListBackgroundColor")
        XCTAssertTrue(label.shadowOffset == CGSize(width: 1.0, height: 1.0), "CGSize should be equal to CGSize(width: 1.0, height: 1.0)")
        XCTAssertTrue(label.shadowColor == UIColor.black, "ShadowColor should be equal to black")
    }

    func testPokemonDetailPokemonLabelStyle() {
        let label = UILabel()
        label.text = "New test"
        label.pokemonDetailPokemonLabelStyle()

        XCTAssertEqual(label.font, UIFont.customItalicFont(withSize: 50), "Font should be of size: 50")
        XCTAssertEqual(label.textColor, UIColor.white, "Text color should be white")
        XCTAssertFalse(label.shadowOffset == CGSize(width: 1.0, height: 1.0), "CGSize should be equal to CGSize(width: 1.0, height: 1.0)")
        XCTAssertTrue(label.shadowColor == UIColor.black, "ShadowColor should be equal to black")
    }


    func testPokemonListEmptyStateStyle() {
        let label = UILabel()
        label.text = "New test"
        label.pokemonListEmptyStateStyle()

        XCTAssertEqual(label.font, UIFont.customRegularFont(withSize: 30), "Font should be of size: 30")
        XCTAssertEqual(label.textColor, UIColor.pokemonRedColor.withAlphaComponent(0.6), "Text color should be pokemonRedColor with alpha 0.6 ")
        XCTAssertFalse(label.shadowOffset == CGSize(width: 1.0, height: 1.0), "CGSize should be equal to CGSize(width: 1.0, height: 1.0)")
        XCTAssertTrue(label.shadowColor == UIColor.black, "ShadowColor should be equal to black")
    }

    // MARK: - DetailsCell
    func testPokemonDetailCellTitleStyle() {
        let label = UILabel()
        label.text = "New test"
        label.pokemonDetailCellTitleStyle()

        XCTAssertEqual(label.font, UIFont.customItalicFont(withSize: 16), "Font should be of size: 16")
        XCTAssertEqual(label.textColor, UIColor.paeanBlackColor.withAlphaComponent(0.6), "Text color should be paeanBlack with alpha 0.6")
    }

    func testPokemonDetailCellDescriptionTitleStyle() {
        let label = UILabel()
        label.text = "New test"
        label.pokemonDetailCellDescriptionTitleStyle()

        XCTAssertEqual(label.font, UIFont.customRegularFont(withSize: 18), "Font should be of size: 18")
        XCTAssertEqual(label.textColor, UIColor.paeanBlackColor.withAlphaComponent(0.8), "Text color should be paeanBlack with alpha 0.8")
    }

    func testPokemonDetailCellDescriptionStyle() {
        let label = UILabel()
        label.text = "New test"
        label.pokemonDetailCellDescriptionStyle()

        XCTAssertEqual(label.font, UIFont.customRegularFont(withSize: 18), "Font should be of size: 18")
        XCTAssertEqual(label.textColor, UIColor.paeanBlackColor.withAlphaComponent(0.8), "Text color should be paeanBlack with alpha 0.8")
    }

    func testPokemonDetailCellSubDescriptionStyle() {
        let label = UILabel()
        label.text = "New test"
        label.pokemonDetailCellSubDescriptionStyle()

        XCTAssertEqual(label.font, UIFont.customRegularFont(withSize: 16), "Font should be of size: 16")
        XCTAssertEqual(label.textColor, UIColor.paeanBlackColor.withAlphaComponent(0.7), "Text color should be paeanBlack with alpha 0.7")
    }
}
