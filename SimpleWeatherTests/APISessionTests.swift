//
//  APISessionTests.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import XCTest

class APISessionTests: XCTestCase {

    func test_whenBuildingURL_thatURLCorrect() {
        let base = "http://api.wunderground.com"
        let paths = ["api", "TEST_KEY", "forecast", "geolookup", "conditions", "forecast10day", "alerts", "hourly", "astronomy", "q", "40.71,-74.json"]
        let url = URLBuilder(base: base, paths: paths, query: nil)
        XCTAssertEqual(url?.absoluteString, "http://api.wunderground.com/api/TEST_KEY/forecast/geolookup/conditions/forecast10day/alerts/hourly/astronomy/q/40.71,-74.json")
    }

    func test_whenBuildingForecastURL_thatURLCorrect() {
        let url = WundergroundForecastURL(apiKey: "TEST_KEY", lat: 40.71, lon: -74)
        XCTAssertEqual(url?.absoluteString, "http://api.wunderground.com/api/TEST_KEY/forecast/geolookup/conditions/forecast10day/alerts/hourly/astronomy/q/40.7100,-74.0000.json")
    }

    func test_whenBuildingRadarURL_thatURLCorrect() {
        let url = WundergroundRadarURL(apiKey: "TEST_KEY", minLat: 1, maxLat: 2.2, minLon: 3.3333, maxLon: 4.44444444, width: 5, height: 6.6666666666)
        XCTAssertEqual(url?.absoluteString, "http://api.wunderground.com/api/TEST_KEY/radar/image.png?height=7&maxlat=2.2000&maxlon=4.4444&minlat=1.0000&minlon=3.3333&rainsnow=1&width=5")
    }
    
    func test_whenCreatingFilePath_withAPIURL_withJSONEndpoint_thatItEndsInJSON() {
        let url = URL(string: "http://api.wunderground.com/api/TEST_KEY/forecast/geolookup/conditions/forecast10day/alerts/hourly/q/40.71,-74.json")!
        let key = url.diskCacheKey
        XCTAssertEqual(key.components(separatedBy: ".").last, "json")
    }

    func test_whenCreatingForecastURL_withLatLon_thatURLExists() {
        let session = APISession(key: "key")
        let url = session.forecastURL(lat: 1, lon: 1)
        XCTAssertNotNil(url)
    }
    
}
