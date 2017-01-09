//
//  SavedLocation+Equatable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

// SavedLocation inherits from NSObject so not using Equatable protocol
func ==(lhs: SavedLocation, rhs: SavedLocation) -> Bool {
    return lhs.userLocation == rhs.userLocation
        && lhs.latitude == rhs.latitude
        && lhs.longitude == rhs.longitude
        && lhs.name == rhs.name
}
