//
//  ForecastDay+JSONConvertible.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/15/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ForecastDay: JSONConvertible {

    static func fromJSON(json: [String : Any]) -> ForecastDay? {
        guard let epoch_string = keypath(dict: json, path: "date.epoch") as String?,
            let date_interval = TimeInterval(epoch_string),
            let high = (keypath(dict: json, path: "high.fahrenheit") as NSString?)?.integerValue,
            let low = (keypath(dict: json, path: "low.fahrenheit") as NSString?)?.integerValue,
            let description = json["conditions"] as? String,
            let pop = json["pop"] as? Int,
            let qpf_allday = keypath(dict: json, path: "qpf_allday.in") as Double?,
            let qpf_day = keypath(dict: json, path: "qpf_day.in") as Double?,
            let qpf_night = keypath(dict: json, path: "qpf_night.in") as Double?,
            let snow_allday = keypath(dict: json, path: "snow_allday.in") as Double?,
            let snow_day = keypath(dict: json, path: "snow_day.in") as Double?,
            let snow_night = keypath(dict: json, path: "snow_night.in") as Double?,
            let icon_name = json["icon"] as? String,
            let avehumidity = json["avehumidity"] as? Int,
            let maxhumidity = json["maxhumidity"] as? Int,
            let minhumidity = json["minhumidity"] as? Int
            else { return nil }

        var max_wind: Wind? = nil
        if let wspd = keypath(dict: json, path: "maxwind.mph") as Double?,
            let wdir = keypath(dict: json, path: "maxwind.dir") as String? {
            max_wind = Wind(speed: wspd, direction: wdir)
        }

        var ave_wind: Wind? = nil
        if let wspd = keypath(dict: json, path: "avewind.mph") as Double?,
            let wdir = keypath(dict: json, path: "avewind.dir") as String? {
            ave_wind = Wind(speed: wspd, direction: wdir)
        }

        return ForecastDay(
            date: Date(timeIntervalSince1970: date_interval),
            high: high,
            low: low,
            description: description,
            pop: Double(pop) / 100.0,
            qpf_allday: qpf_allday,
            qpf_day: qpf_day,
            qpf_night: qpf_night,
            snow_allday: snow_allday,
            snow_day: snow_day,
            snow_night: snow_night,
            avehumidity: avehumidity,
            maxhumidity: maxhumidity,
            minhumidity: minhumidity,
            condition: Condition.from(string: icon_name),
            max_wind: max_wind,
            average_wind: ave_wind
        )
    }

}
