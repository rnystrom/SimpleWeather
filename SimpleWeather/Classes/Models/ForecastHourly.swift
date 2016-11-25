//
//  ForecastHourly.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/14/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct ForecastHourly {

    let date: Date
    let temp: Int
    let dewpoint: Int
    let description: String
    let wx: String
    let uvi: Int
    let humidity: Int
    let windchill: Int
    let heatindex: Int
    let feelslike: Int
    let qpf: Double
    let snow: Double
    let pop: Double
    let mslp: Double
    let wind: Wind
    let condition: Condition

}
