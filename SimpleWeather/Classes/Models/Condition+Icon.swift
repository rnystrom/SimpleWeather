//
//  Condition+Icon.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/26/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Condition {

    func icon(night: Bool = false) -> String {
        switch self {
        case .chanceflurries, .chancesnow, .chancesleet, .flurries, .sleet, .snow:
            return "Snow"
        case .chancerain, .rain:
            return "Mist"
        case .chancetstorms, .tstorms:
            return "Thunder-cloud"
        case .clear, .sunny:
            return night ? "Moon" : "Sun"
        case .cloudy:
            return "Cloudy"
        case .fog, .hazy:
            return "Haze"
        case .mostlycloudy, .partlysunny:
            return night ? "Mostly-sunny-night" : "Partly-sunny-day"
        case .partlycloudy, .mostlysunny:
            return night ? "Mostly-sunny-night" : "Mostly-sunny-day"
        case .unknown:
            return ""
        }

    }

}
