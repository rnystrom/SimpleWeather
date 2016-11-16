//
//  ForecastHourly+JSONConvertible.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/15/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ForecastHourly: JSONConvertible {

    static func fromJSON(json: [String : Any]) -> ForecastHourly? {
        guard let epoch_string = keypath(dict: json, path: "FCTTIME.epoch") as String?,
            let date_interval = TimeInterval(epoch_string),
            let wdir = keypath(dict: json, path: "wdir.dir") as String?,
            let condition = json["condition"] as? String,
            let icon = json["icon"] as? String,
            let wx = json["wx"] as? String,
            let uvi = (json["uvi"] as? NSString)?.integerValue,
            let humidity = (json["humidity"] as? NSString)?.integerValue,
            let pop = (json["pop"] as? NSString)?.doubleValue,
            let temp = (keypath(dict: json, path: "temp.english") as NSString?)?.integerValue,
            let windchill = (keypath(dict: json, path: "windchill.english") as NSString?)?.integerValue,
            let heatindex = (keypath(dict: json, path: "heatindex.english") as NSString?)?.integerValue,
            let feelslike = (keypath(dict: json, path: "feelslike.english") as NSString?)?.integerValue,
            let dewpoint = (keypath(dict: json, path: "dewpoint.english") as NSString?)?.integerValue,
            let wspd = (keypath(dict: json, path: "wspd.english") as NSString?)?.integerValue,
            let qpf = (keypath(dict: json, path: "qpf.english") as NSString?)?.doubleValue,
            let snow = (keypath(dict: json, path: "snow.english") as NSString?)?.doubleValue,
            let mslp = (keypath(dict: json, path: "mslp.english") as NSString?)?.doubleValue
            else { return nil }
        return ForecastHourly(
            date: Date(timeIntervalSince1970: date_interval),
            temp: temp,
            dewpoint: dewpoint,
            condition: condition,
            wx: wx,
            uvi: uvi,
            humidity: humidity,
            windchill: windchill,
            heatindex: heatindex,
            feelslike: feelslike,
            qpf: qpf,
            snow: snow,
            pop: pop,
            mslp: mslp,
            wind: Wind(speed: wspd, direction: wdir),
            icon: ConditionsIcon.from(string: icon)
        )
    }

}
