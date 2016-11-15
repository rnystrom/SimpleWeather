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
    let max_wind: Wind?
    let average_wind: Wind?
    let icon: ConditionsIcon
    let avehumidity: Int
    let maxhumidity: Int
    let minhumidity: Int

    static func parseTemp(key: String, json: [String: Any]) -> Int? {
        guard let tempJSON = json[key] as? [String: String],
            let tempStr = tempJSON["fahrenheit"],
            let temp = Int(tempStr)
            else { return nil }
        return temp
    }

    static func parseTotal(key: String, json: [String: Any]) -> Double? {
        guard let totalJSON = json[key] as? [String: Any],
            let total = totalJSON["in"] as? Double
            else { return nil }
        return total
    }

    init?(json: [String: Any]) {
        guard let date_json = json["date"] as? [String: Any],
            let epoch_string = date_json["epoch"] as? String,
            let date_interval = TimeInterval(epoch_string),
            let high = ForecastDay.parseTemp(key: "high", json: json),
            let low = ForecastDay.parseTemp(key: "low", json: json),
            let conditions = json["conditions"] as? String,
            let pop = json["pop"] as? Int,
            let qpf_allday = ForecastDay.parseTotal(key: "qpf_allday", json: json),
            let qpf_day = ForecastDay.parseTotal(key: "qpf_day", json: json),
            let qpf_night = ForecastDay.parseTotal(key: "qpf_night", json: json),
            let snow_allday = ForecastDay.parseTotal(key: "snow_allday", json: json),
            let snow_day = ForecastDay.parseTotal(key: "snow_day", json: json),
            let snow_night = ForecastDay.parseTotal(key: "snow_night", json: json),
            let icon_name = json["icon"] as? String,
            let avewind_json = json["avewind"] as? [String: Any],
            let maxwind_json = json["maxwind"] as? [String: Any],
            let avehumidity = json["avehumidity"] as? Int,
            let maxhumidity = json["maxhumidity"] as? Int,
            let minhumidity = json["minhumidity"] as? Int
            else { return nil }

        self.date = Date(timeIntervalSince1970: date_interval)
        self.max_wind = Wind(json: maxwind_json)
        self.average_wind = Wind(json: avewind_json)
        self.high = high
        self.low = low
        self.conditions = conditions
        self.pop = Double(pop) / 100.0
        self.qpf_allday = qpf_allday
        self.qpf_day = qpf_day
        self.qpf_night = qpf_night
        self.snow_allday = snow_allday
        self.snow_day = snow_day
        self.snow_night = snow_night
        self.avehumidity = avehumidity
        self.maxhumidity = maxhumidity
        self.minhumidity = minhumidity
        self.icon = ConditionsIcon.from(string: icon_name)
    }
    
}
