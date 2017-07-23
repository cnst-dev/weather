//
//  MainViewController.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 22.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    // MARK: - UITabBarController
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModels()
    }

    // MARK: - Methods
    /// Setups view models for the root view controllers displayed by the tab bar interface.
    func setupViewModels() {
        NetworkClient.shared.getWeather(lat: "52.03", long: "47.8", success: { [weak self] json in
            let state = State(json: json)
            guard let todayViewController = self?.viewControllers?[0] as? TodayWeatherViewController else {
                fatalError("There should be a view controller")
            }
            todayViewController.viewModel = TodayWeatherViewModel(state: state)

        }) { message in
            print(message)
        }
    }
}
