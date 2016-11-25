//
//  Conditions.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/16/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Observation {

    let date: Date
    let weather: String
    let temp: Double
    let humidity: String
    let wind: Wind
    let pressure: Double
    let dewpoint: Double
    let feelslike: Double
    let visibility: Double
    let uvi: Int
    let precip_1hr: Double
    let precip_day: Double
    let icon: ConditionsIcon

}
