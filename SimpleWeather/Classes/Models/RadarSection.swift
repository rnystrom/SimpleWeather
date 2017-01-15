//
//  RadarSection.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/27/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class RadarSection: NSObject {

    let center: CLLocationCoordinate2D

    init(center: CLLocationCoordinate2D) {
        self.center = center
    }

}
