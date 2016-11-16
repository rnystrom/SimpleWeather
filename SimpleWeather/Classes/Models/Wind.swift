//
//  Wind.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/15/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Wind {

    let speed: Int
    let direction: String
    
}

extension Wind: Equatable {

    public static func ==(lhs: Wind, rhs: Wind) -> Bool {
        return lhs.speed == rhs.speed && lhs.direction == rhs.direction
    }

}
