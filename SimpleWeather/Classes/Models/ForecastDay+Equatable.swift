//
//  ForecastDay+Equatable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/10/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ForecastDay: Equatable {

    public static func ==(lhs: ForecastDay, rhs: ForecastDay) -> Bool {
        return lhs.date == rhs.date
            && lhs.high == rhs.high
            && lhs.low == rhs.low
            && lhs.description == rhs.description
            && lhs.pop == rhs.pop
            && lhs.qpf_allday == rhs.qpf_allday
            && lhs.qpf_day == rhs.qpf_day
            && lhs.qpf_night == rhs.qpf_night
            && lhs.snow_allday == rhs.snow_allday
            && lhs.snow_day == rhs.snow_day
            && lhs.snow_night == rhs.snow_night
            && lhs.avehumidity == rhs.avehumidity
            && lhs.maxhumidity == rhs.maxhumidity
            && lhs.minhumidity == rhs.minhumidity
            && lhs.condition == rhs.condition
            && lhs.max_wind == rhs.max_wind
            && lhs.average_wind == rhs.average_wind
    }

}
