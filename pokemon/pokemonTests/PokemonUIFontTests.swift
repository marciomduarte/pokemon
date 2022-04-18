//
//  PokemonUIFontTests.swift
//  pokemonTests
//
//  Created by Márcio Duarte on 16/04/2022.
//

import XCTest

class PokemonUIFontTests: pokemonTests {

    func testCustomRegularFont() {
        let label = UILabel()
        label.font = UIFont.customRegularFont(withSize: 29.0)

        XCTAssertEqual(label.font, UIFont.customRegularFont(withSize: 29), "Font should be of size: 29")
        XCTAssertEqual(label.font.fontName, AppFontName.regular, "Font name should be equal to Ketchum")
    }

    func testCustomItalicFont() {
        let label = UILabel()
        label.font = UIFont.customItalicFont(withSize: 29.0)

        XCTAssertEqual(label.font, UIFont.customItalicFont(withSize: 29.0), "Font should be of size: 29.0")
        XCTAssertEqual(label.font.fontName, AppFontName.italic, "Font name should be equal to Ketchum-Italic")
    }
}
