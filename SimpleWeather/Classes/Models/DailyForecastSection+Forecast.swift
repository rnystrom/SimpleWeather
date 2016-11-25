//
//  DailyForecastSection+Forecast.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/21/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension DailyForecastSection {

    static func from(forecast: Forecast) -> DailyForecastSection? {
        guard let date = forecast.observation?.date,
            let daily = forecast.daily?.sorted(by: { $0.date > $1.date })
            else { return nil }

        var viewModels = [ForecastDayCellViewModel]()
        let limit = 10
        for day in daily {
            let viewModel = ForecastDayCellViewModel(
                date: day.date,
                high:
                day.high,
                low: day.low,
                conditionsEmoji: day.condition.emoji()
            )
            viewModels.append(viewModel)
            if viewModels.count >= limit { break }
        }
        return DailyForecastSection(
            currentDate: date,
            viewModels: viewModels
        )
    }

}
