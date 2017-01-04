//
//  LocationRequester.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationError {
    // system denied auth (e.g. airplane mode)
    case systemDenied

    // user denied auth (e.g. disabling app location)
    case userDenied

    // CLLocationManager failed
    case error(String)

    // location succeeded, but no locations array was empty
    case emptyLocation
}

enum LocationResult {
    case success(CLLocation)
    case failure(LocationError)
}

protocol LocationTrackerDelegate: class {
    func didFinish(tracker: LocationTracker, result: LocationResult)
}

class LocationTracker: NSObject, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    weak var delegate: LocationTrackerDelegate?

    // MARK: Public API

    func getLocation() {
        // set the delegate only when needed, after init
        // prevents didChangeAuthorization spam
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

        next(authorizationStatus: CLLocationManager.authorizationStatus())
    }

    // MARK: Private API

    func next(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("Tracker requesting auth...")
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("Tracker finding location...")
            locationManager.requestLocation()
        case .denied:
            print("Tracker user denied")
            delegate?.didFinish(tracker: self, result: .failure(.userDenied))
        case .restricted:
            print("Tracker system denied")
            delegate?.didFinish(tracker: self, result: .failure(.systemDenied))
        }
    }

    // MARK: CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print("Tracker found location: \(location)")
        manager.stopUpdatingLocation()
        delegate?.didFinish(tracker: self, result: .success(location))
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Tracker failed: " + error.localizedDescription)
        manager.stopUpdatingLocation()
        delegate?.didFinish(tracker: self, result: .failure(.error(error.localizedDescription)))
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        next(authorizationStatus: status)
    }
    
}
