//
//  JSONConvertible.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/15/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol JSONConvertible {
    static func fromJSON(json: [String: Any]) -> Self?
}
