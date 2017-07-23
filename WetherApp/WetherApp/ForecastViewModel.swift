//
//  ForecastViewModel.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 23.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation

class ForecastViewModel {

    // MARK: - Properties
    let stateViewModel: StateViewModel!
    var weatheViewModels = [WeatherViewModel]()

    // MARK: - Inits
    init(state: State) {
        stateViewModel = StateViewModel(name: state.name, country: state.country)
        weatheViewModels = state.forecast.map { WeatherViewModel(weather: $0) }
    }
}
