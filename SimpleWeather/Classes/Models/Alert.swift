//
//  Alert.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/14/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Alert {

    enum Significance {
        case warning, watch, advisory, statement, forecast, outlook, synopsys, unknown
    }

    let description: String
    let date: Date
    let expires: Date
    let message: String
    let phenomena: String
    let significance: Significance

}
