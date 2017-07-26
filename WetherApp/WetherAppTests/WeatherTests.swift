//
//  WeatherTests.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 26.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import WetherApp

class WeatherTests: XCTestCase {

    var validObject: [String: Any]!
    var invalidObject: [String: String]!

    struct Values {
        static let timestamp = 1501012800
        static let temperature = 288.85
        static let pressure = 1020.82
        static let humidity = 100
        static let speed = 1.21
        static let rain = 5.2
        static let main = "Rain"
        static let description = "light rain"
    }

    override func setUp() {
        super.setUp()

        validObject = [
            "dt": Values.timestamp,
            "temp": [
                "day": Values.temperature
            ],
            "pressure": Values.pressure,
            "humidity": Values.humidity,
            "weather": [
                [
                    "main": Values.main,
                    "description": Values.description
                ]
            ],
            "speed": Values.speed,
            "rain": Values.rain
        ]

        invalidObject = ["testKey": "testData"]
    }

    func test_Init_WhenGivenInvalidJSON_SetsNilForProperties() {
        let json = JSON(invalidObject)
        let weather = Weather(json: json)

        XCTAssertNil(weather.temperature)
        XCTAssertNil(weather.timestamp)
        XCTAssertNil(weather.humidity)
        XCTAssertNil(weather.pressure)
        XCTAssertNil(weather.rain)
    }

    func test_Init_WhenGivenInvalidJSON_SetsEmptyStrings() {
        let json = JSON(invalidObject)
        let weather = Weather(json: json)

        XCTAssertEqual(weather.condition, "")
        XCTAssertEqual(weather.description, "")
    }

    func test_Init_WhenGivenValidJSON() {
        let weather = Weather(json: JSON(validObject))

        XCTAssertEqual(weather.temperature, Values.temperature)
        XCTAssertEqual(weather.timestamp, Values.timestamp)
        XCTAssertEqual(weather.humidity, Values.humidity)
        XCTAssertEqual(weather.pressure, Values.pressure)
        XCTAssertEqual(weather.speed, Values.speed)
        XCTAssertEqual(weather.rain, Values.rain)

        XCTAssertEqual(weather.condition, Values.main)
        XCTAssertEqual(weather.description, Values.description)
    }
}
