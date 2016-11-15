//
//  KeypathParsing.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/15/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

public func keypath<T>(dict: [String: Any], path: String) -> T? {
    let keys: [String] = path.components(separatedBy: ".")
    var next = dict
    for key in keys {
        let entry = next[key]
        if let d = entry as? [String: Any] {
            next = d
        } else if let v = entry as? T, key == keys.last {
            return v
        }
    }
    return nil
}
