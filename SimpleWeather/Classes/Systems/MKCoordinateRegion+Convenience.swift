//
//  MKCoordinateRegion+Convenience.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import MapKit
import UIKit

extension MKCoordinateRegion {

    init(center: CLLocationCoordinate2D, width: CLLocationDegrees, size: CGSize) {
        let ratio = size.width / size.height
        let span = MKCoordinateSpan(latitudeDelta: width, longitudeDelta: Double(ratio) * width)
        self.init(center: center, span: span)
    }

}
