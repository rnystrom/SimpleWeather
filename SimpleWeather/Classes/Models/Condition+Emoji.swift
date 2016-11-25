//
//  ConditionsIcon+Emoji.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Condition {

    func emoji(date: Date? = nil, sunrise: Date? = nil, sunset: Date? = nil) -> String {
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.day, .hour]

        let daytime: Bool
        if let date = date {
            let dateComponents = calendar.dateComponents(components, from: date)
            if let sunrise = sunrise,
                let sunset = sunset,
                let day = dateComponents.day,
                calendar.dateComponents(components, from: sunrise).day == day,
                calendar.dateComponents(components, from: sunset).day == day {
                daytime = date > sunrise && date < sunset
            } else if let hour = dateComponents.hour {
                daytime = hour > 6 && hour < 18
            } else {
                daytime = true
            }
        } else {
            daytime = true
        }

        switch self {
        case .chanceflurries: return "🌨"
        case .chancerain: return "🌧"
        case .chancesleet: return "🌨"
        case .chancesnow: return "🌨"
        case .chancetstorms: return "🌩"
        case .clear: return daytime ? "☀️" : "🌙"
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
        case .sunny: return daytime ? "☀️" : "🌙"
        case .tstorms: return "🌩"
        case .unknown: return "🌊"
        }
    }

}
