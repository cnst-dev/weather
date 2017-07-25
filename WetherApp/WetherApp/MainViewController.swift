//
//  MainViewController.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 22.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UITabBarController, LocationServiceDelegate {

    // MARK: - Properties
    let locationService = LocationService()

    // MARK: - UITabBarController
    override func viewDidLoad() {
        super.viewDidLoad()
        locationService.delegate = self
        locationService.requestLocation()
    }

    // MARK: - LocationServiceDelegate
    func locationDidUpdate(_ service: LocationService, location: CLLocation) {
        setupViewModels(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }

    /// Setups view models for the root view controllers displayed by the tab bar interface.
    ///
    /// - Parameters:
    ///   - latitude: A latitude.
    ///   - longitude: A longitude.x
    func setupViewModels(latitude: Double, longitude: Double) {
        NetworkClient.shared.getWeather(latitude: latitude, longitude: longitude, success: { [weak self] json in
            let state = State(json: json)
            guard let todayViewController = self?.viewControllers?[0] as? TodayWeatherViewController else {
                fatalError("There should be a view controller")
            }
            if todayViewController.viewModel == nil {
                todayViewController.viewModel = TodayWeatherViewModel(state: state)
            }
            guard let forecastViewController = self?.viewControllers?[1] as? ForecastViewController else {
                fatalError("There should be a view controller")
            }
            if forecastViewController.viewModel == nil {
                forecastViewController.viewModel = ForecastViewModel(state: state)
            }
        }) { message in
            print(message)
        }
    }
}
