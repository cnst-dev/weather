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

    /// Tells the delegate that the location manager was unable to retrieve a location value.
    ///
    /// - Parameters:
    ///   - service: A location service.
    ///   - error: The error object containing the reason the location or heading could not be retrieved.
    func locationDidFail(_ service: LocationService, error: Error)
}

class LocationService: NSObject, CLLocationManagerDelegate {

    // MARK: - Properties
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var currentError: Error?

    weak var delegate: LocationServiceDelegate?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    /// Requests permission to use location services and the one-time delivery of the user’s current location.
    func requestLocation() {
        currentLocation = nil
        currentError = nil
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    /// Tells the delegate that new location data is available.
    ///
    /// - Parameters:
    ///   - manager: A location manager.
    ///   - locations: An array of CLLocation objects containing the location data.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard currentLocation == nil else { return }
        if let location = locations.first {
            currentLocation = location
            delegate?.locationDidUpdate(self, location: location)
        }
    }

    /// Tells the delegate that the location manager was unable to retrieve a location value.
    ///
    /// - Parameters:
    ///   - manager: A location manager.
    ///   - error: The error object containing the reason the location or heading could not be retrieved.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard currentError == nil else { return }
        currentError = error
        delegate?.locationDidFail(self, error: error)
    }

}
