//
//  WeatherNavigationViewModel.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func WeatherNavigationTitle(location: SavedLocation, forecast: Forecast?) -> String? {
    if location.userLocation == true {
        if let forecast = forecast {
            return forecast.location?.city
        } else {
            return NSLocalizedString("Loading...", comment: "")
        }
    } else {
        return location.name
    }
}

func WeatherNavigationShouldDisplayAlerts(forecast: Forecast?) -> Bool {
    return (forecast?.alerts?.count ?? 0) > 0
}
