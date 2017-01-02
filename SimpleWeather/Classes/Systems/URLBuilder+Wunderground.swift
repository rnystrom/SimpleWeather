//
//  URLBuilder+WeatherUnderground.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func WundergroundURL(
    apiKey: String,
    paths: [String]? = nil,
    query: [String: String]? = nil
    ) -> URL? {
    let apiPaths = ["api", apiKey] + (paths ?? [])
    return URLBuilder(base: "http://api.wunderground.com", paths: apiPaths, query: query)
}

func WundergroundForecastURL(
    apiKey: String,
    lat: Double,
    lon: Double
    ) -> URL? {
    let paths = [
        // order doesn't matter
        "forecast",
        "geolookup",
        "conditions",
        "forecast10day",
        "alerts",
        "hourly",
        "astronomy",
        // order matters
        "q",
        String(format: "%.4f,%.4f.json", lat, lon)] // "40.71,-74.json"
    return WundergroundURL(apiKey: apiKey, paths: paths)
}

func WundergroundRadarURL(
    apiKey: String,
    minLat: Double,
    maxLat: Double,
    minLon: Double,
    maxLon: Double,
    width: Double,
    height: Double
    ) -> URL? {
    let paths = [
        "radar",
        "image.png"
    ]
    let query = [
        "maxlat": String(format: "%.4f", maxLat),
        "maxlon": String(format: "%.4f", maxLon),
        "minlat": String(format: "%.4f", minLat),
        "minlon": String(format: "%.4f", minLon),
        "width": String(format: "%.0f", width),
        "height": String(format: "%.0f", height),
        "rainsnow": "1",
    ]
    return WundergroundURL(apiKey: apiKey, paths: paths, query: query)
}
