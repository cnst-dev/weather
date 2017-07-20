//
//  TodayWeatherViewController.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 19.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import UIKit

class TodayWeatherViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkClient.shared.getWeather(lat: "35", long: "139", success: { dictionary in
            print(dictionary)
        }) { message in
            print(message)
        }
    }
}
