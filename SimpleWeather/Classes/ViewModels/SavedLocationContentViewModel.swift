//
//  SavedLocationCellViewModel.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import MapKit

struct SavedLocationContentViewModel {
    let text: String
    let userLocation: Bool
    let region: MKCoordinateRegion
}
