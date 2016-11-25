//
//  Forecast.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Forecast {

    let location: Location?
    let observation: Observation?
    let alerts: [Alert]?
    let daily: [ForecastDay]?
    let hourly: [ForecastHourly]?

}
