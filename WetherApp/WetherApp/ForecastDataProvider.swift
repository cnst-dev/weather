//
//  ForecastDataProvider.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 23.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import UIKit

class ForecastDataProvider: NSObject, UITableViewDataSource {

    // MARK: - Nested
    struct Keys {
        static let cellIdentifier = "ForecastCell"
    }

    // MARK: - Properties
    var viewModels: [WeatherViewModel]!

    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.cellIdentifier) as? ForecastCell else {
            fatalError("There should be a cell")
        }

        cell.configure(for: viewModels[indexPath.row])

        return cell
    }
}
