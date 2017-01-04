//
//  APISessionTests.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import XCTest

class APISessionTests: XCTestCase {

    func jsonHandler(json: Any) -> Forecast? {
        guard let json = json as? [String: Any],
            // for testing purposes, only parse when "response" key is present
        json["response"] != nil
            else { return nil }
        return Forecast.fromJSON(json: json)
    }

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

    func test_whenHandlingSampleResponse_withNoErrors_thatForecastObjectReturned() {
        let url = Bundle(for: SimpleWeatherTests.self).url(forResource: "sample_response", withExtension: "json")!
        let data = try! Data(contentsOf: url)

        let result = URLSessionDataTaskResponse(
            serializeJSON: true,
            parse: self.jsonHandler
            ).handle(data: data, error: nil)

        switch result {
        case .success(let r):
            XCTAssertEqual(r.location?.city, "Manhattan")
        case .failure(_):
            XCTFail()
        }
    }

    func test_whenHandlingSampleResponse_withNoErrors_withNoData_thatResultEmptyResponse() {
        let result = URLSessionDataTaskResponse(
            serializeJSON: true,
            parse: self.jsonHandler
            ).handle(data: nil, error: nil)

        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .emptyResponse)
        }
    }

    func test_whenHandlingSampleResponse_withNoErrors_withCorruptData_thatResultJSONError() {
        let data = NSKeyedArchiver.archivedData(withRootObject: "someBad:json")

        let result = URLSessionDataTaskResponse(
            serializeJSON: true,
            parse: self.jsonHandler
            ).handle(data: data, error: nil)

        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .json("The data couldn’t be read because it isn’t in the correct format."))
        }
    }

    func test_whenHandlingSampleResponse_withNoErrors_withWrongRootData_thatResultJSONCastingError() {
        // json array not dictionary
        let data = try! JSONSerialization.data(withJSONObject: [ ["key": "value"] ], options: [])

        let result = URLSessionDataTaskResponse(
            serializeJSON: true,
            parse: self.jsonHandler
            ).handle(data: data, error: nil)

        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .jsonCast)
        }
    }

    func test_whenHandlingSampleResponse_withNoErrors_withWrongData_thatResultParsingError() {
        let data = try! JSONSerialization.data(withJSONObject: ["key": "value"], options: [])

        let result = URLSessionDataTaskResponse(
            serializeJSON: true,
            parse: self.jsonHandler
            ).handle(data: data, error: nil)

        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .parsing)
        }
    }

    func test_whenHandlingSampleResponse_withNetworkError_thatResultNetworkError() {
        let error = NSError(domain: "test", code: 100, userInfo: [NSLocalizedDescriptionKey: "Foo bar"])

        let result = URLSessionDataTaskResponse(
            serializeJSON: true,
            parse: self.jsonHandler
            ).handle(data: nil, error: error)

        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .network("Foo bar"))
        }
    }

    func test_whenCreatingFilePath_withAPIURL_withJSONEndpoint_thatItEndsInJSON() {
        let url = URL(string: "http://api.wunderground.com/api/TEST_KEY/forecast/geolookup/conditions/forecast10day/alerts/hourly/q/40.71,-74.json")!
        let key = url.diskCacheKey
        XCTAssertEqual(key.components(separatedBy: ".").last, "json")
    }
    
}
