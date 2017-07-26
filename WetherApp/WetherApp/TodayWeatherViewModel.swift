//
//  TodayWeatherViewModel.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 21.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation

struct TodayWeatherViewModel {

    // MARK: - Properties
    let stateViewModel: StateViewModel!
    let weatherViewModel: WeatherViewModel!

    // MARK: - Inits
    init(state: State) {
        stateViewModel = StateViewModel(name: state.name, country: state.country)
        let todayWeathers = state.forecast[0]
        weatherViewModel = WeatherViewModel(weather: todayWeathers)
    }
}
