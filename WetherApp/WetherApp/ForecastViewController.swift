//
//  ForecastViewController.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 19.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var dataProvider: ForecastDataProvider!

    // MARK: - Properties
    var viewModel: ForecastViewModel! {
        didSet {
            dataProvider.viewModels = viewModel.weatherViewModels
        }
    }

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        stateLabel.text = viewModel.stateViewModel.stateName
        tableView.dataSource = dataProvider
    }
}
