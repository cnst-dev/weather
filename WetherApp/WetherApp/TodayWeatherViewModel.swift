//
//  TodayWeatherViewModel.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 21.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation

struct TodayWeatherViewModel {

    // MARK: - Properties
    let stateDescription: String
    let temperatureDescription: String
    let humidity: String
    let pressure: String
    let speed: String
    let rain: String

    // MARK: - Inits
    init(state: State) {
        stateDescription = "\(state.name), \(state.country)"

        let todayWeather = state.forecast[0]

        let temperatureString = TodayWeatherViewModel.celciusString(temperature: todayWeather.temperature)

        temperatureDescription = "\(temperatureString) | \(todayWeather.condition)"
        humidity = "\(todayWeather.humidity)%"
        pressure = TodayWeatherViewModel.pressureString(pressure: todayWeather.pressure)
        speed = TodayWeatherViewModel.speedString(speed: todayWeather.speed)
        rain = TodayWeatherViewModel.rainString(rain: todayWeather.rain)
    }
}

// MARK: - Formatters
extension TodayWeatherViewModel {

    fileprivate static func celciusString(temperature: Double) -> String {
        return String(format: "%0.0f ºC", temperature - 273.15)
    }

    fileprivate static func speedString(speed: Double) -> String {
        return String(format: "%0.0f km/h", speed * 3.6)
    }

    fileprivate static func pressureString(pressure: Double) -> String {
        return String(format: "%0.0f hPa", pressure)
    }

    fileprivate static func rainString(rain: Double) -> String {
        return String(format: "%0.1f mm", rain)
    }

}
