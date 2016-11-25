//
//  EmbeddedSection+Forecast.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension EmbeddedSection {

    static func from(forecast: Forecast) -> EmbeddedSection? {
        guard let hourly = forecast.hourly?.sorted(by: { $0.date < $1.date }) else { return nil }

        var viewModels = [ForecastHourCellViewModel]()
        let limit = 24
        for hour in hourly {
            let viewModel = ForecastHourCellViewModel(
                date: hour.date,
                temp: hour.temp,
                conditionsEmoji: hour.condition.emoji
            )
            viewModels.append(viewModel)
            if viewModels.count >= limit { break }
        }
        return EmbeddedSection(identifier: "hourly" as NSString, items: viewModels)
    }
    
}

