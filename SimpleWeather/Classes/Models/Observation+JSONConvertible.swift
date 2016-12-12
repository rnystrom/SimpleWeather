//
//  Conditions+JSONConvertible.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/16/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Observation: JSONConvertible {

    static func fromJSON(json: [String : Any]) -> Observation? {
        guard let epoch_string = json["observation_epoch"] as? String,
            let epoch_interval = TimeInterval(epoch_string),
            let weather = json["weather"] as? String,
            let temp = json["temp_f"] as? Double,
            let humidity = json["relative_humidity"] as? String,
            let wdir = json["wind_dir"] as? String,
            let wspd = json["wind_mph"] as? Double,
            let pressure = (json["pressure_in"] as? NSString)?.doubleValue,
            let dewpoint = json["dewpoint_f"] as? Double,
            let feelslike = (json["feelslike_f"] as? NSString)?.integerValue,
            let visibility = (json["visibility_mi"] as? NSString)?.doubleValue,
            let uvi = (json["UV"] as? NSString)?.integerValue,
            let precip_1hr = (json["precip_1hr_in"] as? NSString)?.doubleValue,
            let precip_day = (json["precip_today_in"] as? NSString)?.doubleValue,
            let icon_string = json["icon"] as? String
            else { return nil }

        let condition = Condition.from(string: icon_string)
        let wind = Wind(speed: (wspd < 0 ? 0 : wspd), direction: wdir)

        return Observation(
            date: Date(timeIntervalSince1970: epoch_interval),
            weather: weather,
            temp: temp,
            humidity: humidity,
            wind: wind,
            pressure: pressure,
            dewpoint: dewpoint,
            feelslike: feelslike,
            visibility: (visibility < 0 ? 0 : visibility),
            uvi: uvi,
            precip_1hr: (precip_1hr < 0 ? 0 : precip_1hr),
            precip_day: (precip_day < 0 ? 0 : precip_day),
            condition: condition
        )
    }
    
}
