//
//  URLBuilder.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func URLBuilder(base: String, paths: [String]? = nil, query: [String: String]? = nil) -> URL? {
    guard let baseURL = URL(string: base) else { preconditionFailure("Base not convertible to URL: " + base) }
    var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
    components?.queryItems = query?
        .map { (k, v) in URLQueryItem(name: k, value: v) }

    if NSClassFromString("XCTestCase") != nil {
        components?.queryItems = components?.queryItems?.sorted { $0.name < $1.name }
    }

    components?.path = "/" + (paths?.joined(separator: "/") ?? "")
    return components?.url
}
