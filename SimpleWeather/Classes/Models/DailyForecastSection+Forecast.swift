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
            let daily = forecast.daily?.sorted(by: { $0.date < $1.date })
            else { return nil }

        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.day]
        let observationDay = calendar.dateComponents(components, from: date).day

        var viewModels = [ForecastDayCellViewModel]()
        let limit = 10
        for day in daily {
            // dont include daily forecasts when already have observations
            guard viewModels.count < limit else { break }
            guard observationDay != calendar.dateComponents(components, from: day.date).day else { continue }

            // implicit unwrap b/c there has to be first/last to be inside this iteration
            let position: ForecastDayCellPosition = day == daily.first ? .top : day == daily.last ? .bottom : .none

            let viewModel = ForecastDayCellViewModel(
                date: day.date,
                high:
                day.high,
                low: day.low,
                conditionImageName: day.condition.icon(),
                chancePrecip: day.pop,
                position: position
            )
            viewModels.append(viewModel)
        }
        return DailyForecastSection(
            currentDate: date,
            viewModels: viewModels
        )
    }

}
