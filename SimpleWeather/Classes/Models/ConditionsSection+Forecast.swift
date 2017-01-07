//
//  ConditionsSection+Forecast.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/11/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ConditionsSection {

    static func from(forecast: Forecast?) -> ConditionsSection? {
        guard let observation = forecast?.observation,
            let today = forecast?.daily?.sorted(by: { $0.date > $1.date }).first,
            let astronomy = forecast?.astronomy
            else { return nil }

        return ConditionsSection(
            temperature: Int(observation.temp),
            high: today.high,
            low: today.low,
            condition: observation.condition,
            feelsLike: observation.feelslike,
            wind: observation.wind,
            date: observation.date,
            humidity: observation.humidity,
            dewpoint: observation.dewpoint,
            pressure: observation.pressure,
            visibility: observation.visibility,
            precip_1hr: observation.precip_1hr,
            description: observation.weather,
            timeOfDay: Date().timeOfDay(sunrise: astronomy.sunrise, sunset: astronomy.sunset)
        )
    }
    
}
