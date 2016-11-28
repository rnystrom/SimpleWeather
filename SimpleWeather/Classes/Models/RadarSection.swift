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

    // this is in degrees
    let width: CLLocationDegrees

    init(center: CLLocationCoordinate2D, width: CLLocationDegrees) {
        self.center = center
        self.width = width
    }

    func region(_ size: CGSize) -> MKCoordinateRegion {
        let ratio = size.width / size.height
        let span = MKCoordinateSpan(latitudeDelta: width, longitudeDelta: Double(ratio) * width)
        return MKCoordinateRegion(center: center, span: span)
    }

}
