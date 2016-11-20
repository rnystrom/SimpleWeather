//
//  ConditionsCellViewModel.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

class ConditionsCellViewModel {

    let temperature: Int
    let high: Int
    let low: Int
    let conditionsEmoji: String

    init(temperature: Int, high: Int, low: Int, conditionsEmoji: String) {
        self.temperature = temperature
        self.high = high
        self.low = low
        self.conditionsEmoji = conditionsEmoji
    }

    var temperatureLabelText: String {
        return String(format: "%@ %zi°", conditionsEmoji, temperature)
    }

    var highLowLabelText: String {
        return String(format: "%zi° / %zi°", high, low)
    }
    
}
