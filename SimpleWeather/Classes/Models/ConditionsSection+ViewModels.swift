//
//  ConditionsSection+ViewModels.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/11/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ConditionsSection {

    var viewModels: [Any] {
        var models = [Any]()

        let conditions = ConditionsCellViewModel(
            temperature: temperature,
            high: high,
            low: low,
            conditionImageName: condition.icon(night: timeOfDay == .night),
            feelsLike: feelsLike
        )
        models.append(conditions)

        return models
    }

}
