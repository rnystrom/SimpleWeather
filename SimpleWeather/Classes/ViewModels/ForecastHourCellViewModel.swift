//
//  ForecastHourCellViewModel.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

class ForecastHourCellViewModel {

    static private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "h a"
        return df
    }()

    let date: Date
    let temp: Int
    let conditionsEmoji: String

    init(date: Date, temp: Int, conditionsEmoji: String) {
        self.date = date
        self.temp = temp
        self.conditionsEmoji = conditionsEmoji
    }

    var dateString: String {
        return ForecastHourCellViewModel.dateFormatter.string(from: date)
    }

    var tempString: String {
        return String(format: "%zi°", temp)
    }

}
