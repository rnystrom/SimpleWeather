//
//  Astronomy+JSONConvertibel.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/25/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Astronomy: JSONConvertible {

    static func fromJSON(json: [String : Any]) -> Astronomy? {
        guard let illumination = (json["percentIlluminated"] as? NSString)?.doubleValue,
            let age = (json["ageOfMoon"] as? NSString)?.integerValue,
        let phase = json["phaseofMoon"] as? String,
        let hemi = json["hemisphere"] as? String,
        let sunriseHour = (keypath(dict: json, path: "sunrise.hour") as NSString?)?.integerValue,
        let sunriseMinute = (keypath(dict: json, path: "sunrise.minute") as NSString?)?.integerValue,
        let sunsetHour = (keypath(dict: json, path: "sunset.hour") as NSString?)?.integerValue,
        let sunsetMinute = (keypath(dict: json, path: "sunset.minute") as NSString?)?.integerValue,
        let moonriseHour = (keypath(dict: json, path: "moonrise.hour") as NSString?)?.integerValue,
        let moonriseMinute = (keypath(dict: json, path: "moonrise.minute") as NSString?)?.integerValue,
        let moonsetHour = (keypath(dict: json, path: "moonset.hour") as NSString?)?.integerValue,
        let moonsetMinute = (keypath(dict: json, path: "moonset.minute") as NSString?)?.integerValue
            else { return nil }
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var components = calendar.dateComponents([.year, .month, .day], from: Date())

        components.hour = sunriseHour
        components.minute = sunriseMinute
        guard let sunrise = calendar.date(from: components) else { return nil }

        components.hour = sunsetHour
        components.minute = sunsetMinute
        guard let sunset = calendar.date(from: components) else { return nil }

        components.hour = moonriseHour
        components.minute = moonriseMinute
        guard let moonrise = calendar.date(from: components) else { return nil }

        components.hour = moonsetHour
        components.minute = moonsetMinute
        guard let moonset = calendar.date(from: components) else { return nil }

        return Astronomy(
            sunrise: sunrise,
            sunset: sunset,
            moonrise: moonrise,
            moonset: moonset,
            moonIllumination: illumination / 100.0,
            moonAge: age,
            moonPhaseDescription: phase,
            moonHemisphere: hemi
        )
    }

}
