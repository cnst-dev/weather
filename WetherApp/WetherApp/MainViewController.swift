//
//  MainViewController.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 22.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import UIKit
import CoreLocation
import NVActivityIndicatorView
import SCLAlertView

class MainViewController: UITabBarController {

    // MARK: - Nested.
    private struct Keys {
        static let message = "message"
    }
    fileprivate struct Strings {
        static let internetError = "Internet ERROR"
        static let locationError = "Location ERROR"
        static let tryAgain = "Try Again!"
        static let loadData = "Load weather data..."
        static let checkLocation = "Check the location..."
    }

    // MARK: - Properties
    let locationService = LocationService()

    // MARK: - UITabBarController
    override func viewDidLoad() {
        super.viewDidLoad()
        locationService.delegate = self

        requestLocation()
    }

    // MARK: - Methods
    /// Setups view models for the root view controllers displayed by the tab bar interface.
    ///
    /// - Parameters:
    ///   - latitude: A latitude.
    ///   - longitude: A longitude.
    fileprivate func setupViewModels(latitude: Double, longitude: Double) {
        NetworkClient.shared.getWeather(latitude: latitude, longitude: longitude, success: { [weak self] json in
            self?.indicator.stopAnimating()
            let state = State(json: json)
            guard let todayViewController = self?.viewControllers?[0] as? TodayWeatherViewController else {
                fatalError("There should be a view controller")
            }
            todayViewController.viewModel = TodayWeatherViewModel(state: state)

            guard let forecastViewController = self?.viewControllers?[1] as? ForecastViewController else {
                fatalError("There should be a view controller")
            }
            forecastViewController.viewModel = ForecastViewModel(state: state)
        }) { [weak self] message in
            let subTitle = message[Keys.message] as? String ?? ""
            self?.showAlertView(title: Strings.internetError, subTitle: subTitle)
        }
    }

    /// Shows an alert view.
    ///
    /// - Parameters:
    ///   - title: A title.
    ///   - subTitle: A subtitle.
    fileprivate func showAlertView(title: String, subTitle: String) {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton(Strings.tryAgain, target: self, selector: #selector(requestLocation))

        alertView.showError(title, subTitle: subTitle)
    }
}

// MARK: - LocationServiceDelegate
extension MainViewController: LocationServiceDelegate {

    func locationDidUpdate(_ service: LocationService, location: CLLocation) {
        indicator.setMessage(Strings.loadData)
        setupViewModels(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }

    func locationDidFail(_ service: LocationService, error: Error) {
        indicator.stopAnimating()
        showAlertView(title: Strings.locationError, subTitle: error.localizedDescription)
    }

    /// Requests the user’s current location.
    func requestLocation() {
        startIndicator()
        locationService.requestLocation()
    }
}

// MARK: - NVActivityIndicatorViewable
extension MainViewController: NVActivityIndicatorViewable {

    /// Shared instance of NVActivityIndicatorPresenter.
    var indicator: NVActivityIndicatorPresenter {
        return NVActivityIndicatorPresenter.sharedInstance
    }

    /// Displays UI blocker with indicator.
    func startIndicator() {
        indicator.stopAnimating()
        let activityData = ActivityData(
            size: CGSize(width: 100, height: 75),
            message: Strings.checkLocation, messageFont: nil,
            type: NVActivityIndicatorType.pacman, color: UIColor.lightGray,
            padding: nil,
            displayTimeThreshold: nil, minimumDisplayTime: nil,
            backgroundColor: UIColor.white, textColor: nil)

        indicator.startAnimating(activityData)
    }
}
