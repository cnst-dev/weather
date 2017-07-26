//
//  WeatherUITests.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 26.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import XCTest

class WeatherUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func test_TodayWeatherView_SetsOnStart() {
        let app = XCUIApplication()

        XCTAssertTrue(app.staticTexts["Today"].exists)
        XCTAssertEqual(app.staticTexts.count, 8)
    }

    func test_ForecastView_SetsTable_WhenTabBarPressed() {
        let app = XCUIApplication()

        app.tabBars.buttons["Forecast"].tap()

        XCTAssertEqual(app.tables.cells.count, 7)
    }
}
