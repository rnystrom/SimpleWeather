//
//  LocationRequester.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentLocationRequester: NSObject, CLLocationManagerDelegate {

    private lazy var locationManager: CLLocationManager = {
        let l = CLLocationManager()
        l.delegate = self
        l.desiredAccuracy = kCLLocationAccuracyKilometer
        return l
    }()
    private var completion: ((CLLocation?, Error?) -> Void)?
    var authorizationRequested = false

    // MARK: Public API

    func getLocation(completion: @escaping (CLLocation?, Error?) -> Void) {
        if CLLocationManager.locationServicesEnabled() {
            self.completion = completion
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                requestLocation()
            case .notDetermined:
                print("Authorizing location access...")
                authorizationRequested = true
                locationManager.requestWhenInUseAuthorization()
            default:
                completion(nil, nil)
            }
        } else {
            completion(nil, nil)
        }
    }

    // MARK: Private API

    func requestLocation() {
        print("Requesting location...")
        locationManager.requestLocation()
    }

    // MARK: CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location found at \(locations.first)")
        completion?(locations.first, nil)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: " + error.localizedDescription)
        completion?(nil, error)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            if authorizationRequested {
                requestLocation()
            }
        default:
            completion?(nil, nil)
        }
    }
    
}
