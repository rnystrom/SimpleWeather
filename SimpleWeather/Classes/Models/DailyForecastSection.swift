//
//  DailyForecastSection.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/20/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

class DailyForecastSection {

    let currentDate: Date
    let viewModels: [ForecastDayCellViewModel]

    init(currentDate: Date, viewModels: [ForecastDayCellViewModel]) {
        self.currentDate = currentDate
        self.viewModels = viewModels
    }

}
