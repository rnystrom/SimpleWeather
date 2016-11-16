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
            let conditions = json["conditions"] as? String,
            let pop = json["pop"] as? Int,
            let qpf_allday = keypath(dict: json, path: "qpf_allday.in") as Double?,
            let qpf_day = keypath(dict: json, path: "qpf_day.in") as Double?,
            let qpf_night = keypath(dict: json, path: "qpf_night.in") as Double?,
            let snow_allday = keypath(dict: json, path: "snow_allday.in") as Double?,
            let snow_day = keypath(dict: json, path: "snow_day.in") as Double?,
            let snow_night = keypath(dict: json, path: "snow_night.in") as Double?,
            let icon_name = json["icon"] as? String,
            let avewind_json = json["avewind"] as? [String: Any],
            let maxwind_json = json["maxwind"] as? [String: Any],
            let avehumidity = json["avehumidity"] as? Int,
            let maxhumidity = json["maxhumidity"] as? Int,
            let minhumidity = json["minhumidity"] as? Int
            else { return nil }
        return ForecastDay(
            date: Date(timeIntervalSince1970: date_interval),
            high: high,
            low: low,
            conditions: conditions,
            pop: Double(pop) / 100.0,
            qpf_allday: qpf_allday,
            qpf_day: qpf_day,
            qpf_night: qpf_night,
            snow_allday: snow_allday,
            snow_day: snow_day,
            snow_night: snow_night,
            icon: ConditionsIcon.from(string: icon_name),
            avehumidity: avehumidity,
            maxhumidity: maxhumidity,
            minhumidity: minhumidity,
            max_wind: Wind(json: maxwind_json),
            average_wind: Wind(json: avewind_json)
        )
    }

}
