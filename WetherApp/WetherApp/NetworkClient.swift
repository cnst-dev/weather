//
//  NetworkClient.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 20.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation
import Alamofire

class NetworkClient {

    // MARK: - Nested
    private struct URLKeys {
        static let type = "forecast"
        static let latitudePrefix = "?lat="
        static let longitudePrefix = "&lon="
        static let appIDPrefix = "&appid="
    }

    // MARK: - Properties
    private let baseURLString: String
    private let apiKey: String
    private let headers = ["Content-Type": "application/json"]

    /// A closure to call when the request is successed.
    typealias Success = ([String: Any]) -> Void
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

        guard let urlString = dictionary["base_url"] as? String else {
                fatalError("There should be a base url string")
        }

        guard let apiKey = dictionary["api_key"] as? String else {
                fatalError("There should be an API key")
        }

        return NetworkClient(baseURLString: urlString, apiKey: apiKey)

    }()

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
                    success(dictionary)
                } else {
                    failure(dictionary)
                }
            case .failure(let error):
                print("ERROR", error.localizedDescription)
            }
        }
    }

    /// Gets weather data.
    ///
    /// - Parameters:
    ///   - lat: A latitude.
    ///   - long: A longitude.
    ///   - success: A closure to call when the request is successed.
    ///   - failure: A closure to call when the request is failed.
    func getWeather(lat: String, long: String, success: @escaping Success, failure: @escaping Failure) {
        let latitudeComponent = "\(URLKeys.latitudePrefix)\(lat)"
        let longitudeComponent = "\(URLKeys.longitudePrefix)\(long)"
        let idComponent = "\(URLKeys.appIDPrefix)\(apiKey)"

        let pathComponent = "\(URLKeys.type)\(latitudeComponent)\(longitudeComponent)\(idComponent)"

        let url = URL(string: "\(baseURLString)\(pathComponent)")!

        request(url: url, success: { dictionary in
            success(dictionary)
        }) { message in
            failure(message)
        }
    }
}
