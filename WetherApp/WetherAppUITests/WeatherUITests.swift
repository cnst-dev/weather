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

    func test_TodayWeatherView_SetsLabels() {
        let app = XCUIApplication()

        XCTAssertTrue(app.staticTexts["100%"].exists)
        XCTAssertTrue(app.staticTexts["San Francisco, US"].exists)
        XCTAssertTrue(app.staticTexts["16ºC | Rain"].exists)
        XCTAssertTrue(app.staticTexts["1021 hPa"].exists)
        XCTAssertTrue(app.staticTexts["4 km/h"].exists)
        XCTAssertTrue(app.staticTexts["Today"].exists)
    }

    func test_ForecastView_SetsTable_WhenTabBarPressed() {
        let app = XCUIApplication()

        app.tabBars.buttons["Forecast"].tap()

        XCTAssertTrue(app.staticTexts["San Francisco"].exists)
        XCTAssertEqual(app.tables.cells.count, 7)
    }
}
