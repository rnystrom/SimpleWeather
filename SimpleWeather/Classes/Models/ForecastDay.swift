//
//  ForecastDay.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/14/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct ForecastDay {

    let date: Date
    let high: Int
    let low: Int
    let description: String
    let pop: Double
    let qpf_allday: Double
    let qpf_day: Double
    let qpf_night: Double
    let snow_allday: Double
    let snow_day: Double
    let snow_night: Double
    let avehumidity: Int
    let maxhumidity: Int
    let minhumidity: Int
    let condition: Condition
    let max_wind: Wind?
    let average_wind: Wind?
    
}
