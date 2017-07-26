//
//  StateViewModel.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 23.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation

struct StateViewModel {

    // MARK: - Properties
    let stateName: String
    let stateDescription: String

    // MARK: - Inits
    init(name: String, country: String) {
        stateName = name
        stateDescription = "\(name), \(country)"
    }
}
