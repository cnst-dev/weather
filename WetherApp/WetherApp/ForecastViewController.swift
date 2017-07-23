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

    // MARK: - Properties
    var viewModel: ForecastViewModel!

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        stateLabel.text = viewModel.stateViewModel.stateName
    }
}
