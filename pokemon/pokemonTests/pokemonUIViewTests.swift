//
//  pokemonUIViewTests.swift
//  pokemonTests
//
//  Created by Márcio Duarte on 16/04/2022.
//

import XCTest

class pokemonUIViewTests: pokemonTests {

    func testSetShadow() {
        let viewTest: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
        viewTest.setShadow()

        XCTAssertTrue(viewTest.layer.shadowColor == UIColor.black.cgColor, "ShadowColor should be of black")
        XCTAssertTrue(viewTest.layer.shadowOffset == .zero, "ShadowOffset should be of equal to zero")
        XCTAssertTrue(viewTest.layer.shadowOpacity == 1, "ShadowOpacity should be of equal to 1")
        XCTAssertFalse(viewTest.layer.shadowRadius != 8, "ShadowRadius should be of equal to 8")
    }
}
