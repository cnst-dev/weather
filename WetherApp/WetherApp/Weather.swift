//
//  Weather.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 21.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Weather {

    // MARK: - Nested
    private struct Keys {
        static let temp = "temp"
        static let day = "day"
        static let dt = "dt"
        static let humidity = "humidity"
        static let pressure = "pressure"
        static let weather = "weather"
        static let main = "main"
        static let description = "description"
        static let speed = "speed"
        static let rain = "rain"
    }

    // MARK: - Properties
    let timestamp: Int?
    let temperature: Double?
    let humidity: Int?
    let condition: String
    let description: String
    let pressure: Double?
    let speed: Double?
    let rain: Double?

    // MARK: - Inits
    init(json: JSON) {
        timestamp = json[Keys.dt].int
        temperature = json[Keys.temp][Keys.day].double
        humidity = json[Keys.humidity].int
        pressure = json[Keys.pressure].double
        condition = json[Keys.weather][0][Keys.main].stringValue
        description = json[Keys.weather][0][Keys.description].stringValue
        speed = json[Keys.speed].double
        rain = json[Keys.rain].double
    }
}
