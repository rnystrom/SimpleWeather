//
//  SavedLocation+NSEncoding.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/18/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

let SavedLocationNameKey = "name"
let SavedLocationLatitudeKey = "latitude"
let SavedLocationLongitudeKey = "longitude"
let SavedLocationUserLocationKey = "userLocation"

extension SavedLocation: NSCoding {

    convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: SavedLocationNameKey) as? String
            else { return nil }
        let latitude = aDecoder.decodeDouble(forKey: SavedLocationLatitudeKey)
        let longitude = aDecoder.decodeDouble(forKey: SavedLocationLongitudeKey)
        let userLocation = aDecoder.decodeBool(forKey: SavedLocationUserLocationKey)
        self.init(name: name, latitude: latitude, longitude: longitude, userLocation: userLocation)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: SavedLocationNameKey)
        aCoder.encode(latitude, forKey: SavedLocationLatitudeKey)
        aCoder.encode(longitude, forKey: SavedLocationLongitudeKey)
        aCoder.encode(userLocation, forKey: SavedLocationUserLocationKey)
    }

}
