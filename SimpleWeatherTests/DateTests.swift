//
//  DateTests.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/26/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import XCTest

class DateTests: XCTestCase {
    
    func test_thatTimeOfDayIsDay_whenDateBetweenSunriseSunset() {
        let sunrise = Date(timeIntervalSince1970: 20)
        let sunset = Date(timeIntervalSince1970: 24)
        let date = Date(timeIntervalSince1970: 22)
        XCTAssertEqual(date.timeOfDay(sunrise: sunrise, sunset: sunset), .day)
    }

    func test_thatTimeOfDayIsNight_whenDateBeforeSunrise_whenSameDay() {
        let sunrise = Date(timeIntervalSince1970: 20)
        let sunset = Date(timeIntervalSince1970: 24)
        let date = Date(timeIntervalSince1970: 19)
        XCTAssertEqual(date.timeOfDay(sunrise: sunrise, sunset: sunset), .night)
    }

    func test_thatTimeOfDayIsNight_whenDateAfterSunset_whenSameDay() {
        let sunrise = Date(timeIntervalSince1970: 20)
        let sunset = Date(timeIntervalSince1970: 24)
        let date = Date(timeIntervalSince1970: 25)
        XCTAssertEqual(date.timeOfDay(sunrise: sunrise, sunset: sunset), .night)
    }

    func test_thatTimeOfDayIsDay_whenTimeBetween6And18_whenNoSunriseSunset() {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .hour], from: Date())
        components.hour = 12
        XCTAssertEqual(calendar.date(from: components)!.timeOfDay(), .day)
    }

    func test_thatTimeOfDayIsNight_whenTimeBefore6_whenNoSunriseSunset() {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .hour], from: Date())
        components.hour = 5
        XCTAssertEqual(calendar.date(from: components)!.timeOfDay(), .night)
    }

    func test_thatTimeOfDayIsNight_whenTimeAfter18_whenNoSunriseSunset() {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .hour], from: Date())
        components.hour = 19
        XCTAssertEqual(calendar.date(from: components)!.timeOfDay(), .night)
    }
    
}
