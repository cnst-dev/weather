//
//  State.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 21.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation
import SwiftyJSON

struct State {

    // MARK: - Nested
    private struct Keys {
        static let city = "city"
        static let name = "name"
        static let country = "country"
        static let list = "list"
    }

    // MARK: - Properties
    let name: String
    let country: String
    var forecast = [Weather]()

    // MARK: - Init
    init(json: JSON) {
        name = json[Keys.city][Keys.name].stringValue
        country = json[Keys.city][Keys.country].stringValue

        let objects = json[Keys.list].arrayValue

        for json in objects {
            let dayWeather = Weather(json: json)
            forecast.append(dayWeather)
        }
    }
}
