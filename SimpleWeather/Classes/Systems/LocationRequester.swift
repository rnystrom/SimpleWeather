//
//  LocationRequester.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import CoreLocation

class LocationRequester: NSObject, CLLocationManagerDelegate {

    private lazy var locationManager: CLLocationManager = {
        let l = CLLocationManager()
        l.delegate = self
        l.desiredAccuracy = kCLLocationAccuracyKilometer
        return l
    }()
    private var completion: ((CLLocation?, Error?) -> Void)?
    var authRequested = false

    // MARK: Public API

    func getLocation(completion: @escaping (CLLocation?, Error?) -> Void) {
        if CLLocationManager.locationServicesEnabled() {
            self.completion = completion
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.requestLocation()
            case .notDetermined:
                authRequested = true
                locationManager.requestWhenInUseAuthorization()
            default:
                completion(nil, nil)
            }
        } else {
            completion(nil, nil)
        }
    }

    // MARK: CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        completion?(locations.first, nil)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(nil, error)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            if authRequested == true {
                locationManager.requestLocation()
            }
        default: return
        }
    }
    
}
