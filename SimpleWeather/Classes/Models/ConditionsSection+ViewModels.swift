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

        models.append(ConditionsDetailCellViewModel(title: "Conditions", detail: description))
        models.append(ConditionsDetailCellViewModel(title: "Feels Like", detail: String(format: "%zi°", feelsLike)))
        models.append(ConditionsDetailCellViewModel(title: "Wind", detail: String(format: "%.0f mph %@", wind.speed, wind.direction)))
        models.append(ConditionsDetailCellViewModel(title: "Humidity", detail: String(format: "%@", humidity)))
        models.append(ConditionsDetailCellViewModel(title: "Dewpoint", detail: String(format: "%.0f°", dewpoint)))
        models.append(ConditionsDetailCellViewModel(title: "Pressure", detail: String(format: "%.2f", pressure)))
        models.append(ConditionsDetailCellViewModel(title: "Chance of rain", detail: String(format: "%.0f%%", precip_1hr * 100.0)))
        models.append(ConditionsDetailCellViewModel(title: "Visibility", detail: String(format: "%.0f mi", visibility)))

        return models
    }

}
