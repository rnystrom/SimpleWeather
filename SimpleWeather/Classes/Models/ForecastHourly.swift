//
//  ForecastHourly.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/14/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct ForecastHourly {

    static func extractMetric(json: Any?) -> String? {
        guard let json = json as? [String: Any]
            else { return nil }
        return json["english"] as? String
    }

    let date: Date
    let temp: Int
    let dewpoint: Int
    let condition: String
    let wspd: Int
    let wdir: String
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
    let icon: ConditionsIcon

    init?(json: [String: Any]) {
        guard let epoch_string = keypath(dict: json, path: "FCTTIME.epoch") as String?,
            let date_interval = TimeInterval(epoch_string),
            let temp = (keypath(dict: json, path: "temp.english") as NSString?)?.integerValue,
            let dewpoint = (keypath(dict: json, path: "dewpoint.english") as NSString?)?.integerValue,
            let condition = json["condition"] as? String,
            let icon = json["icon"] as? String,
            let wspd = (keypath(dict: json, path: "wspd.english") as NSString?)?.integerValue,
            let wdir = keypath(dict: json, path: "wdir.dir") as String?,
            let wx = json["wx"] as? String,
            let uvi = (json["uvi"] as? NSString)?.integerValue,
            let humidity = (json["humidity"] as? NSString)?.integerValue,
            let windchill = (keypath(dict: json, path: "windchill.english") as NSString?)?.integerValue,
            let heatindex = (keypath(dict: json, path: "heatindex.english") as NSString?)?.integerValue,
            let feelslike = (keypath(dict: json, path: "feelslike.english") as NSString?)?.integerValue,
            let qpf = (keypath(dict: json, path: "qpf.english") as NSString?)?.doubleValue,
            let snow = (keypath(dict: json, path: "snow.english") as NSString?)?.doubleValue,
            let pop = (json["pop"] as? NSString)?.doubleValue,
            let mslp = (keypath(dict: json, path: "mslp.english") as NSString?)?.doubleValue
            else { return nil }

        self.date = Date(timeIntervalSince1970: date_interval)
        self.temp = temp
        self.dewpoint = dewpoint
        self.condition = condition
        self.wspd = wspd
        self.wdir = wdir
        self.wx = wx
        self.uvi = uvi
        self.humidity = humidity
        self.windchill = windchill
        self.heatindex = heatindex
        self.feelslike = feelslike
        self.qpf = qpf
        self.snow = snow
        self.pop = pop
        self.mslp = mslp
        self.icon = ConditionsIcon.from(string: icon)
    }
    
}
