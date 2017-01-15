//
//  SimpleWeatherUITests.swift
//  SimpleWeatherUITests
//
//  Created by Ryan Nystrom on 1/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest

class SimpleWeatherUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_weather_screen() {
        XCUIApplication().collectionViews.scrollViews.otherElements.containing(.staticText, identifier:"New York").children(matching: .other).element.children(matching: .other).element.children(matching: .map).element.tap()
        sleep(2)
        snapshot("01WeatherScreen")
    }

    func test_locations_screen() {
        sleep(2)
        snapshot("02LocationsScreen")
    }
    
}
