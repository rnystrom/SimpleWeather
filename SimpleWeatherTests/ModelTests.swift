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

}
