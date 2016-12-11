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
    let conditionImageName: String
    let feelsLike: Int

    init(temperature: Int, high: Int, low: Int, conditionImageName: String, feelsLike: Int) {
        self.temperature = temperature
        self.high = high
        self.low = low
        self.conditionImageName = conditionImageName
        self.feelsLike = feelsLike
    }

    var temperatureLabelText: String {
        return String(format: "%zi°", temperature)
    }

    var highLowLabelText: NSAttributedString {
        return highLowAttributedString(high: high, low: low, size: 18)
    }

    var feelsLikeText: String? {
        return temperature != feelsLike ? String(format: "(%zi°)", feelsLike) : nil
    }
    
}
