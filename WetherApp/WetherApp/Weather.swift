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
        static let humidity = "humidity"
        static let pressure = "pressure"
        static let weather = "weather"
        static let main = "main"
        static let speed = "speed"
        static let rain = "rain"
    }

    // MARK: - Properties
    let temperature: Double
    let humidity: Int
    let condition: String
    let pressure: Double
    let speed: Double
    let rain: Double

    // MARK: - Init
    init(json: JSON) {
        temperature = json[Keys.temp][Keys.day].doubleValue
        humidity = json[Keys.humidity].intValue
        pressure = json[Keys.pressure].doubleValue
        condition = json[Keys.weather][0][Keys.main].stringValue
        speed = json[Keys.speed].doubleValue
        rain = json[Keys.rain].doubleValue
    }
}
