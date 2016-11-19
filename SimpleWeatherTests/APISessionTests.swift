//
//  APISessionTests.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import XCTest

class APISessionTests: XCTestCase {
    
    func test_whenCreatingFilePath_withAPIURL_withJSONEndpoint_thatItEndsInJSON() {
        let url = URL(string: "http://api.wunderground.com/api/TEST_KEY/forecast/geolookup/conditions/forecast10day/alerts/hourly/q/40.71,-74.json")!
        let key = url.diskCacheKey
        XCTAssertEqual(key.components(separatedBy: ".").last, "json")
    }
    
}
