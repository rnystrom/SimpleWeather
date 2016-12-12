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
            max_wind = Wind(speed: max(wspd, 0), direction: wdir)
        }

        var ave_wind: Wind? = nil
        if let wspd = keypath(dict: json, path: "avewind.mph") as Double?,
            let wdir = keypath(dict: json, path: "avewind.dir") as String? {
            ave_wind = Wind(speed: max(wspd, 0), direction: wdir)
        }

        return ForecastDay(
            date: Date(timeIntervalSince1970: date_interval),
            high: high,
            low: low,
            description: description,
            pop: max(Double(pop) / 100.0, 0),
            qpf_allday: max(qpf_allday, 0),
            qpf_day: max(qpf_day, 0),
            qpf_night: max(qpf_night, 0),
            snow_allday: max(snow_allday, 0),
            snow_day: max(snow_day, 0),
            snow_night: max(snow_night, 0),
            avehumidity: avehumidity,
            maxhumidity: maxhumidity,
            minhumidity: minhumidity,
            condition: Condition.from(string: icon_name),
            max_wind: max(max_wind, 0),
            average_wind: max(ave_wind, 0)
        )
    }

}
