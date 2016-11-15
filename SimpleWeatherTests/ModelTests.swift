//
//  SimpleWeatherTests.swift
//  SimpleWeatherTests
//
//  Created by Ryan Nystrom on 11/14/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import XCTest

class SimpleWeatherTests: XCTestCase {

    let sampleJSONResponse: [String: Any] = {
        // hard crash on all of this if something is wrong
        let url = Bundle(for: SimpleWeatherTests.self).url(forResource: "sample_response", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    }()

    func test_thatAlertCreated_fromValidJSON() {
        let json = [
            "type": "HEA",
            "description": "Heat Advisory",
            "date": "11:14 am CDT on July 3, 2012",
            "date_epoch": "1341332040",
            "expires": "7:00 AM CDT on July 07, 2012",
            "expires_epoch": "1341662400",
            "message": "Porta Elit Inceptos Vulputate Dapibus",
            "phenomena": "HT",
            "significance": "Y"
            ]
        let alert = Alert(json: json)
        XCTAssertNotNil(alert)
    }

    func test_thatAlertCreated_fromSampleJSON() {
        let json = (sampleJSONResponse["alerts"] as! [ [String: Any] ]).first!
        let alert = Alert(json: json)
        XCTAssertNotNil(alert)
    }

    func test_thatLocationCreated_fromValidJSON() {
        let json = [
            "type": "CITY",
            "country": "US",
            "country_iso3166": "US",
            "country_name": "USA",
            "state": "NY",
            "city": "Manhattan",
            "tz_short": "EST",
            "tz_long": "America/New_York",
            "lat": "40.710000",
            "lon": "-74.000000",
            "zip": "11201",
            "magic": "9",
            "wmo": "99999",
            "l": "/q/zmw:11201.9.99999",
            "requesturl": "US/NY/Fulton_Ferry.html",
            "wuiurl": "https://www.wunderground.com/US/NY/Fulton_Ferry.html"
            ]
        let location = Location(json: json)
        XCTAssertNotNil(location)
    }

    func test_thatLocationCreated_fromSampleJSON() {
        let json = sampleJSONResponse["location"] as! [String: Any]
        let location = Location(json: json)
        XCTAssertNotNil(location)
    }

    func test_thatForecastDayCreated_fromValidJSON() {
        let json: [String: Any] = [
            "date": [
                "epoch": "1479168000",
            ],
            "high": [
                "fahrenheit": "64",
            ],
            "low": [
                "fahrenheit": "50",
            ],
            "conditions": "Partly Cloudy",
            "icon": "partlycloudy",
            "pop": 50,
            "qpf_allday": [
                "in": 0.13,
            ],
            "qpf_day": [
                "in": 0.0,
            ],
            "qpf_night": [
                "in": 0.13,
            ],
            "snow_allday": [
                "in": 0.0,
            ],
            "snow_day": [
                "in": 0.0,
            ],
            "snow_night": [
                "in": 0.0,
            ],
            "maxwind": [
                "mph": 10,
                "dir": "SW",
            ],
            "avewind": [
                "mph": 5,
                "dir": "SW",
            ],
            "avehumidity": 39,
            "maxhumidity": 56,
            "minhumidity": 30
        ]
        let forecast = ForecastDay(json: json)
        XCTAssertNotNil(forecast)
    }

    func test_thatForecastDayCreated_fromSampleJSON() {
        let forecast_json = sampleJSONResponse["forecast"] as! [String: Any]
        let simpleforecast = forecast_json["simpleforecast"] as! [String: Any]
        let forecastday = simpleforecast["forecastday"] as! [ [String: Any] ]
        let forecast = ForecastDay(json: forecastday.first!)
        XCTAssertNotNil(forecast)
    }

}
