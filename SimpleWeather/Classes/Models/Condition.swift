//
//  ConditionsIcon.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/14/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

enum Condition {
    case chanceflurries, chancerain, chancesleet, chancesnow, chancetstorms, clear, cloudy, flurries, fog, hazy, mostlycloudy, mostlysunny, partlycloudy, partlysunny, sleet, rain, snow, sunny, tstorms, unknown

    static func from(string: String) -> Condition {
        switch string {
        case "chanceflurries": return .chanceflurries
        case "chancerain": return .chancerain
        case "chancesleet": return .chancesleet
        case "chancesnow": return .chancesnow
        case "chancetstorms": return .chancetstorms
        case "clear": return .clear
        case "cloudy": return .cloudy
        case "flurries": return .flurries
        case "fog": return .fog
        case "hazy": return .hazy
        case "mostlycloudy": return .mostlycloudy
        case "mostlysunny": return .mostlysunny
        case "partlycloudy": return .partlycloudy
        case "partlysunny": return .partlysunny
        case "sleet": return .sleet
        case "rain": return .rain
        case "snow": return .snow
        case "sunny": return .sunny
        case "tstorms": return .tstorms
        default: return .unknown
        }
    }
}
