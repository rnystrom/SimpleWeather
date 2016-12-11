//
//  ConditionsSection.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/11/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

class ConditionsSection {

    let temperature: Int
    let high: Int
    let low: Int
    let condition: Condition
    let feelsLike: Int
    let wind: Wind
    let date: Date
    let humidity: String
    let dewpoint: Double
    let pressure: Double
    let visibility: Double
    let precip_1hr: Double
    let description: String
    let timeOfDay: TimeOfDay

    init(
        temperature: Int,
        high: Int,
        low: Int,
        condition: Condition,
        feelsLike: Int,
        wind: Wind,
        date: Date,
        humidity: String,
        dewpoint: Double,
        pressure: Double,
        visibility: Double,
        precip_1hr: Double,
        description: String,
        timeOfDay: TimeOfDay
        ) {
        self.temperature = temperature
        self.high = high
        self.low = low
        self.condition = condition
        self.feelsLike = feelsLike
        self.wind = wind
        self.date = date
        self.humidity = humidity
        self.dewpoint = dewpoint
        self.pressure = pressure
        self.visibility = visibility
        self.precip_1hr = precip_1hr
        self.description = description
        self.timeOfDay = timeOfDay
    }

}
