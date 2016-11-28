//
//  RadarOverlay.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/27/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import MapKit

class RadarOverlay: NSObject, MKOverlay {

    let coordinate: CLLocationCoordinate2D
    let boundingMapRect: MKMapRect

    init(coordinate: CLLocationCoordinate2D, boundingMapRect: MKMapRect) {
        self.coordinate = coordinate
        self.boundingMapRect = boundingMapRect
    }

}
