//
//  pokemonListAndDetailsTests.swift
//  pokemonUITests
//
//  Created by Márcio Duarte on 16/04/2022.
//

import XCTest

class pokemonListAndDetailsTests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testCellClickAndGoToAbilities() {

        let app = XCUIApplication()

        let firstCellOfCollectionView = app.collectionViews.children(matching: .any).element(boundBy: 0)
        XCTAssertTrue(firstCellOfCollectionView.exists)

        if firstCellOfCollectionView.exists {
            // Sleep 10seconds to wait service response
            sleep(10)
            firstCellOfCollectionView.tap()
        }

        let segmentedControlDetails = app.segmentedControls.matching(identifier: Constants().kSegmentedControlIdentifier).element
        XCTAssertTrue(segmentedControlDetails.exists, "Segmented control needs to be visivel to select the detail type")

        XCTAssertTrue(segmentedControlDetails.buttons["Abilities"].exists, "Segmented control have Abilities button")
        if segmentedControlDetails.buttons["Abilities"].exists {
            segmentedControlDetails.buttons["Abilities"].tap()

            // Sleep 3 second to wait tableView update
            sleep(3)
        }
    }

    func testSearchWithError() {

        let app = XCUIApplication()

        let searchBar = app.searchFields.element(boundBy: 0)
        // Sleep 10 to wait for the service response
        sleep(10)
        searchBar.tap()

        let firstKey = app.keys["T"]
        firstKey.tap()

        let secondKey = app.keys["e"]
        secondKey.tap()

        let thirdKey = app.keys["s"]
        thirdKey.tap()

        let fourtyKey = app.keys["t"]
        fourtyKey.tap()

        let searchButton = app.buttons["Search"]
        searchButton.tap()

        let noDataView = app.otherElements[Constants().kEmptyListPokemonIdentifier]
        XCTAssertTrue(noDataView.exists == true, "NoDataView needs to be visibel because pokemon with ID 9000 doesn't exist.")
    }
}
