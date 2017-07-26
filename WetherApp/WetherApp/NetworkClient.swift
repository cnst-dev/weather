//
//  NetworkClient.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 20.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkClient {

    // MARK: - Nested
    private struct URLKeys {
        static let type = "forecast/daily"
        static let latitudePrefix = "?lat="
        static let longitudePrefix = "&lon="
        static let appIDPrefix = "&appid="
        static let daysCountPrefix = "&cnt="
    }

    private struct Keys {
        static let baseUrl = "base_url"
        static let api = "api_key"
    }

    // MARK: - Properties
    private let baseURLString: String
    private let apiKey: String

    /// A closure to call when the request is successed.
    typealias Success = (JSON) -> Void
    /// A closure to call when the request is failed.
    typealias Failure = ([String: Any]) -> Void

    /// Returns the shared NetworkClient object
    static let shared: NetworkClient = {
        guard let file = Bundle.main.path(
            forResource: "ServerSettings",
            ofType: "plist") else {
            fatalError("There should be a settings file")
        }

        guard let dictionary = NSDictionary(contentsOfFile: file) else {
                fatalError("There should be a config dictionary")
        }

        guard let urlString = dictionary[Keys.baseUrl] as? String else {
                fatalError("There should be a base url string")
        }

        guard let apiKey = dictionary[Keys.api] as? String else {
                fatalError("There should be an API key")
        }

        return NetworkClient(baseURLString: urlString, apiKey: apiKey)

    }()

    // MARK: - Inits
    private init(baseURLString: String, apiKey: String) {
        self.baseURLString = baseURLString
        self.apiKey = apiKey
    }

    /// Creates a request to the site.
    ///
    /// - Parameters:
    ///   - url: An URL.
    ///   - success: A closure to call when the request is successed.
    ///   - failure: A closure to call when the request is failed.
    fileprivate func request(url: URL, success: @escaping Success, failure: @escaping Failure) {
        Alamofire.request(url).responseJSON { response in

            switch response.result {
            case .success(let value):
                guard let dictionary =  value as? [String: Any] else {
                    fatalError("There should be a dictionary")
                }

                if let statusCode = response.response?.statusCode,
                    200 <= statusCode && statusCode < 300 {
                    let json = JSON(value)
                    success(json)
                } else {
                    failure(dictionary)
                }
            case .failure(let error):
                failure(["message": error.localizedDescription])
            }
        }
    }

    /// Gets weather data.
    ///
    /// - Parameters:
    ///   - latitude: A latitude.
    ///   - longitude: A longitude.
    ///   - daysCount: A days count for weather.
    ///   - success: A closure to call when the request is successed.
    ///   - failure: A closure to call when the request is failed.
    func getWeather(latitude: Double, longitude: Double, daysCount: Int = 8, success: @escaping Success, failure: @escaping Failure) {
        let coordinateComponent = "\(URLKeys.latitudePrefix)\(latitude)\(URLKeys.longitudePrefix)\(longitude)"
        let idComponent = "\(URLKeys.appIDPrefix)\(apiKey)"
        let daysComponent = "\(URLKeys.daysCountPrefix)\(daysCount)"

        let pathComponent = "\(URLKeys.type)\(coordinateComponent)\(idComponent)\(daysComponent)"

        let url = URL(string: "\(baseURLString)\(pathComponent)")!

        request(url: url, success: { dictionary in
            success(dictionary)
        }) { message in
            failure(message)
        }
    }
}
