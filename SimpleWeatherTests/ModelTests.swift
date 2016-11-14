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
        let json: [String: Any] = [
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

}
