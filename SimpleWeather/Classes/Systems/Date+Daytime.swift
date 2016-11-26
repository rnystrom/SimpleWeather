//
//  Date+Daytime.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/26/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

enum TimeOfDay {
    case day, night, unknown
}

extension Date {

    func timeOfDay(sunrise: Date? = nil, sunset: Date? = nil, calendar: Calendar = .current) -> TimeOfDay {
        let components: Set<Calendar.Component> = [.day, .hour]

        let daytime: Bool
        let dateComponents = calendar.dateComponents(components, from: self)
        if let sunrise = sunrise,
            let sunset = sunset,
            let day = dateComponents.day,
            calendar.dateComponents(components, from: sunrise).day == day,
            calendar.dateComponents(components, from: sunset).day == day {
            daytime = self > sunrise && self < sunset
        } else if let hour = dateComponents.hour {
            daytime = hour > 6 && hour < 18
        } else {
            return .unknown
        }
        return daytime ? .day : .night
    }

}
