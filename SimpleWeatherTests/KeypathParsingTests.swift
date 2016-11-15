//
//  KeypathParsingTests.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/15/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import XCTest

class KeypathParsingTests: XCTestCase {

    func test_whenKeypathExists_withProperValueCast_thatValueReturned() {
        let dict = [ "a": [ "b" : "1" ] ]
        let result: String? = keypath(dict: dict, path: "a.b")
        XCTAssertEqual(result, "1")
    }

    func test_whenKeypathExists_withIncorrectValueCast_thatValueReturned() {
        let dict = [ "a": [ "b" : "1" ] ]
        let result: Int? = keypath(dict: dict, path: "a.b")
        XCTAssertNil(result)
    }

    func test_whenKeypathNotDeepEnough_thatNilReturned() {
        let dict = [ "a": [ "b" : "1" ] ]
        let result: String? = keypath(dict: dict, path: "a")
        XCTAssertNil(result)
    }

    func test_whenKeypathDoesNotExist_withTooDeep_thatNilReturned() {
        let dict = [ "a": [ "b" : "1" ] ]
        let result: String? = keypath(dict: dict, path: "a.b.c")
        XCTAssertNil(result)
    }

    func test_whenKeypathDoesNotExist_withCorrectDepth_thatValueReturned() {
        let dict = [ "a": [ "b" : "1" ] ]
        let result: String? = keypath(dict: dict, path: "a.c")
        XCTAssertNil(result)
    }
    
}
