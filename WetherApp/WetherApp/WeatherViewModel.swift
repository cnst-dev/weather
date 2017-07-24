//
//  WeatherViewModel.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 23.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation

class WeatherViewModel {

    // MARK: - Nested
    fileprivate struct Keys {
        static let imageSun = "Sun_Big"
        static let imageDefault = "Default"
        static let imageWind = "WInd_Big"
        static let imageCloydy = "Cloudy_Big"
        static let imageLightning = "Lightning_Big"
    }

    fileprivate enum WeatherType: String {
        case thunderstorm, rain, drizzle, clear, clouds

        var imageName: String {
            switch self {
            case .clear:
                return Keys.imageSun
            case .clouds:
                return Keys.imageCloydy
            case .thunderstorm:
                return Keys.imageWind
            case .rain, .drizzle:
                return Keys.imageLightning
            }
        }
    }

    // MARK: - Properties
    let fullDescription: String
    let temperatureDescription: String
    let weatherDescription: String
    let humidity: String
    let pressure: String
    let speed: String
    let rain: String
    let imageName: String
    let day: String

    // MARK: - Inits
    init(weather: Weather) {
        temperatureDescription = WeatherViewModel.celciusString(temperature: weather.temperature)
        weatherDescription = weather.condition

        fullDescription = "\(temperatureDescription)C | \(weatherDescription)"

        humidity = "\(weather.humidity)%"
        pressure = WeatherViewModel.pressureString(pressure: weather.pressure)
        speed = WeatherViewModel.speedString(speed: weather.speed)
        rain = WeatherViewModel.rainString(rain: weather.rain)

        imageName = WeatherViewModel.imageString(for: weather.description)

        let date = Date(timeIntervalSince1970: TimeInterval(weather.timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        day = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
    }
}

// MARK: - Formatters
extension WeatherViewModel {

    /// Returns a String object of temperature.
    ///
    /// - Parameter temperature: A temperature String in Kelvin.
    /// - Returns: A temperature String in Celcius.
    fileprivate static func celciusString(temperature: Double) -> String {
        return String(format: "%0.0fº", temperature - 273.15)
    }

    /// Returns a String object of speed.
    ///
    /// - Parameter speed: A temperature Double in m/s.
    /// - Returns: A temperature String in km/h.
    fileprivate static func speedString(speed: Double) -> String {
        return String(format: "%0.0f km/h", speed * 3.6)
    }

    /// Returns a String object of pressure.
    ///
    /// - Parameter pressure: A presure Double in hPa.
    /// - Returns: A presure String in hPa.
    fileprivate static func pressureString(pressure: Double) -> String {
        return String(format: "%0.0f hPa", pressure)
    }

    /// Returns a String object of rain.
    ///
    /// - Parameter rain: A rain Double in mm.
    /// - Returns: A rain String in mm.
    fileprivate static func rainString(rain: Double) -> String {
        return String(format: "%0.1f mm", rain)
    }

    /// Returns an image name String object for a weather description.
    ///
    /// - Parameter description: A weather description String.
    /// - Returns: An image name String.
    fileprivate static func imageString(for description: String) -> String {
        if description.lowercased().contains(WeatherType.clear.rawValue) {
            return WeatherType.clear.imageName
        }
        if description.lowercased().contains(WeatherType.clouds.rawValue) {
            return WeatherType.clouds.imageName
        }
        if description.lowercased().contains(WeatherType.thunderstorm.rawValue) {
            return WeatherType.thunderstorm.imageName
        }
        if description.lowercased().contains(WeatherType.rain.rawValue) {
            return WeatherType.rain.imageName
        }
        if description.lowercased().contains(WeatherType.drizzle.rawValue) {
            return WeatherType.rain.imageName
        }

        return Keys.imageDefault
    }
}
