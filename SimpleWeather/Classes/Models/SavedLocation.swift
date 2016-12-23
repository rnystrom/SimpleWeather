//
//  SavedLocation.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/18/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

final class SavedLocation: NSObject {

    let name: String
    let latitude: Double
    let longitude: Double
    let userLocation: Bool

    init(name: String, latitude: Double, longitude: Double, userLocation: Bool) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.userLocation = userLocation
    }

}
