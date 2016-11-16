//
//  ForecastDay.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/14/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct ForecastDay {

    struct Wind {
        let speed: Int
        let direction: String

        init?(json: [String: Any]) {
            guard let mph = json["mph"] as? Int,
                let dir = json["dir"] as? String
                else { return nil }
            self.speed = mph
            self.direction = dir
        }
    }

    let date: Date
    let high: Int
    let low: Int
    let conditions: String
    let pop: Double
    let qpf_allday: Double
    let qpf_day: Double
    let qpf_night: Double
    let snow_allday: Double
    let snow_day: Double
    let snow_night: Double
    let icon: ConditionsIcon
    let avehumidity: Int
    let maxhumidity: Int
    let minhumidity: Int

    let max_wind: Wind?
    let average_wind: Wind?
    
}
