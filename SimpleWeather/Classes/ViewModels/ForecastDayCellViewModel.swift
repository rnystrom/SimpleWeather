//
//  ForecastDayCellViewModel.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/20/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct ForecastDayCellViewModel {

    static private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        return df
    }()

    let date: Date
    let high: Int
    let low: Int
    let conditionsEmoji: String

    var dateString: String {
        return ForecastDayCellViewModel.dateFormatter.string(from: date)
    }

    var highLowConditionsString: String {
        return String(format: "%@ %zi° / %zi°", conditionsEmoji, high, low)
    }

}
