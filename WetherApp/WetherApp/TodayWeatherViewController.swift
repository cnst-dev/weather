//
//  TodayWeatherViewController.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 19.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import UIKit

class TodayWeatherViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var rainLabel: UILabel!
    @IBOutlet private  weak var pressureLabel: UILabel!
    @IBOutlet private weak var speedLabel: UILabel!

    // MARK: - Properties
    var viewModel: TodayWeatherViewModel! {
        didSet {
            stateLabel.text = viewModel.stateViewModel.stateDescription
            temperatureLabel.text = viewModel.weatherViewModel.fullDescription
            humidityLabel.text = viewModel.weatherViewModel.humidity
            rainLabel.text = viewModel.weatherViewModel.rain
            pressureLabel.text = viewModel.weatherViewModel.pressure
            speedLabel.text = viewModel.weatherViewModel.speed

            guard let image = UIImage(named: viewModel.weatherViewModel.imageName) else { return }
            weatherImage.image = image
        }
    }
}
