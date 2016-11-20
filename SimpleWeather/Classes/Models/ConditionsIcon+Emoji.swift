//
//  ConditionsIcon+Emoji.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ConditionsIcon {

    var emoji: String {
        switch self {
        case .chanceflurries: return "🌨"
        case .chancerain: return "🌧"
        case .chancesleet: return "🌨"
        case .chancesnow: return "🌨"
        case .chancetstorms: return "🌩"
        case .clear: return "☀️"
        case .cloudy: return "☁️"
        case .flurries: return "🌨"
        case .fog: return "🌫"
        case .hazy: return "🌫"
        case .mostlycloudy: return "🌥"
        case .mostlysunny: return "🌤"
        case .partlycloudy: return "⛅️"
        case .partlysunny: return "⛅️"
        case .sleet: return "🌨"
        case .rain: return "🌧"
        case .snow: return "🌨"
        case .sunny: return "☀️"
        case .tstorms: return "🌩"
        case .unknown: return "🌊"
        }
    }

}
