//
//  WeatherViewModel.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 23.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation

struct WeatherViewModel {

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

        humidity = WeatherViewModel.humidityString(humidity: weather.humidity)
        pressure = WeatherViewModel.pressureString(pressure: weather.pressure)
        speed = WeatherViewModel.speedString(speed: weather.speed)
        rain = WeatherViewModel.rainString(rain: weather.rain)

        imageName = WeatherViewModel.imageString(for: weather.description)

        day = WeatherViewModel.dayString(timestamp: weather.timestamp)
    }
}

// MARK: - Formatters
extension WeatherViewModel {

    /// Returns a String object of temperature.
    ///
    /// - Parameter temperature: A temperature String in Kelvin.
    /// - Returns: A temperature String in Celcius.
    fileprivate static func celciusString(temperature: Double?) -> String {
        guard let temperature = temperature else { return "-" }
        return String(format: "%0.0fº", temperature - 273.15)
    }

    /// Returns a String object of speed.
    ///
    /// - Parameter speed: A speed Double in m/s.
    /// - Returns: A speed String in km/h.
    fileprivate static func speedString(speed: Double?) -> String {
        guard let speed = speed else { return "-" }
        return String(format: "%0.0f km/h", speed * 3.6)
    }

    /// Returns a String object of humidity.
    ///
    /// - Parameter speed: A humidity Double in m/s.
    /// - Returns: A humidity String in km/h.
    fileprivate static func humidityString(humidity: Int?) -> String {
        guard let humidity = humidity else { return "-" }
        return "\(humidity)%"
    }

    /// Returns a String object of pressure.
    ///
    /// - Parameter pressure: A presure Double in hPa.
    /// - Returns: A presure String in hPa.
    fileprivate static func pressureString(pressure: Double?) -> String {
        guard let pressure = pressure else { return "-" }
        return String(format: "%0.0f hPa", pressure)
    }

    /// Returns a String object of rain.
    ///
    /// - Parameter rain: A rain Double in mm.
    /// - Returns: A rain String in mm.
    fileprivate static func rainString(rain: Double?) -> String {
        guard let rain = rain else { return "-" }
        return String(format: "%0.1f mm", rain)
    }

    /// Returns a day name.
    ///
    /// - Parameter rain: A rain Double in mm.
    /// - Returns: A rain String in mm.
    fileprivate static func dayString(timestamp: Int?) -> String {
        guard let timestamp = timestamp else { return "-" }
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        let day = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        return day
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
