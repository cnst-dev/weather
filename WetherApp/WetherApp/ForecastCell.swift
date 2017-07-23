//
//  ForecastCell.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 23.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!

    /// Sets labels and weatherImage for the cell.
    ///
    /// - Parameter viewModel: A viewModel for the cell.
    func configure(for viewModel: WeatherViewModel) {
        weatherLabel.text = viewModel.weatherDescription
        temperatureLabel.text = viewModel.temperatureDescription
        weatherImage.image = UIImage(named: viewModel.imageName)
        dayLabel.text = viewModel.day
    }
}
