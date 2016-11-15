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
        guard let date_json = json["FCTTIME"] as? [String: Any],
            let epoch_string = date_json["epoch"] as? String,
            let date_interval = TimeInterval(epoch_string),
            let temp_string = ForecastHourly.extractMetric(json: json["temp"]),
            let temp = Int(temp_string),
            let dewpoint_string = ForecastHourly.extractMetric(json: json["dewpoint"]),
            let dewpoint = Int(dewpoint_string),
            let condition = json["condition"] as? String,
            let icon_string = json["icon"] as? String,
            let wspd_string = ForecastHourly.extractMetric(json: json["wspd"]),
            let wspd = Int(wspd_string),
            let wdir_json = json["wdir"] as? [String: String],
            let wdir = wdir_json["dir"],
            let wx = json["wx"] as? String,
            let uvi_string = json["uvi"] as? String,
            let uvi = Int(uvi_string),
            let humidity_string = json["humidity"] as? String,
            let humidity = Int(humidity_string),
            let windchill_string = ForecastHourly.extractMetric(json: json["windchill"]),
            let windchill = Int(windchill_string),
            let heatindex_string = ForecastHourly.extractMetric(json: json["heatindex"]),
            let heatindex = Int(heatindex_string),
            let feelslike_string = ForecastHourly.extractMetric(json: json["feelslike"]),
            let feelslike = Int(feelslike_string),
            let qpf_string = ForecastHourly.extractMetric(json: json["qpf"]),
            let qpf = Double(qpf_string),
            let snow_string = ForecastHourly.extractMetric(json: json["snow"]),
            let snow = Double(snow_string),
            let pop_string = json["pop"] as? String,
            let pop = Double(pop_string),
            let mslp_string = ForecastHourly.extractMetric(json: json["mslp"]),
            let mslp = Double(mslp_string)
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
        self.icon = ConditionsIcon.from(string: icon_string)
    }
    
}
