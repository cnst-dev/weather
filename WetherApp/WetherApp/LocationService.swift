//
//  LocationService.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 24.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: class {

    /// Tells the delegate that location data is updated.
    ///
    /// - Parameters:
    ///   - service: A location service.
    ///   - location: A CLLocation object containing the location data.
    func locationDidUpdate(_ service: LocationService, location: CLLocation)
}

class LocationService: NSObject, CLLocationManagerDelegate {

    // MARK: - Properties
    private let locationManager = CLLocationManager()

    weak var delegate: LocationServiceDelegate?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    /// Requests permission to use location services and the one-time delivery of the user’s current location.
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    /// Tells the delegate that new location data is available.
    ///
    /// - Parameters:
    ///   - manager: A location manager.
    ///   - locations: An array of CLLocation objects containing the location data.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            delegate?.locationDidUpdate(self, location: location)
        }
    }

    /// Tells the delegate that the location manager was unable to retrieve a location value.
    ///
    /// - Parameters:
    ///   - manager: A location manager.
    ///   - error: The error object containing the reason the location or heading could not be retrieved.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error finding location: \(error.localizedDescription)")
    }

}
