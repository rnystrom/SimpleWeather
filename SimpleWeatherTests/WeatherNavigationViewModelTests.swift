//
//  WeatherNavigationViewModelTests.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest

class WeatherNavigationViewModelTests: XCTestCase {

    func test_whenCreatingTitle_withLocation_withNoUserLocation_withNoForecast_thatResultIsLocation() {
        let savedLocation = SavedLocation(name: "Foo", latitude: 1, longitude: 2, userLocation: false)
        XCTAssertEqual(WeatherNavigationTitle(location: savedLocation, forecast: nil), "Foo")
    }

    func test_whenCreatingTitle_withLocation_withUserLocation_withNoForecast_thatResultIsLoading() {
        let savedLocation = SavedLocation(name: "Foo", latitude: 1, longitude: 2, userLocation: true)
        let title = WeatherNavigationTitle(location: savedLocation, forecast: nil)
        XCTAssertNotNil(title)
        XCTAssertNotEqual(title, savedLocation.name)
        XCTAssertGreaterThan(title!.characters.count, 0)
    }

    func test_whenCreatingTitle_withLocation_withUserLocation_withForecast_thatResultIsForecast() {
        let savedLocation = SavedLocation(name: "Foo", latitude: 1, longitude: 2, userLocation: true)
        let location = Location(
            type: "type",
            country: "country",
            country_iso3166: "country_iso",
            country_name: "country_name",
            state: "state",
            city: "city",
            tz_short: "tz_short",
            tz_long: "tz_long",
            lat: 0,
            lon: 1,
            zip: 2,
            magic: "magic",
            wmo: "wmo",
            l: "l",
            requesturl: "requesturl",
            wuiurl: "wuiurl"
        )
        let forecast = Forecast(location: location, observation: nil, alerts: nil, daily: nil, hourly: nil, astronomy: nil)
        XCTAssertEqual(WeatherNavigationTitle(location: savedLocation, forecast: forecast), "city")
    }

    func test_whenCreatingTitle_withLocation_withNoUserLocation_withForecast_thatResultIsLocation() {
        let savedLocation = SavedLocation(name: "Foo", latitude: 1, longitude: 2, userLocation: false)
        let location = Location(
            type: "type",
            country: "country",
            country_iso3166: "country_iso",
            country_name: "country_name",
            state: "state",
            city: "city",
            tz_short: "tz_short",
            tz_long: "tz_long",
            lat: 0,
            lon: 1,
            zip: 2,
            magic: "magic",
            wmo: "wmo",
            l: "l",
            requesturl: "requesturl",
            wuiurl: "wuiurl"
        )
        let forecast = Forecast(location: location, observation: nil, alerts: nil, daily: nil, hourly: nil, astronomy: nil)
        XCTAssertEqual(WeatherNavigationTitle(location: savedLocation, forecast: forecast), "Foo")
    }
    
}

