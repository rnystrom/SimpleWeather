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

        let windString = wind.speed > 0 ? String(format: "%.0f mph %@", wind.speed, wind.direction) : "--"
        models.append(ConditionsDetailCellViewModel(title: "Wind", detail: windString))
        
        models.append(ConditionsDetailCellViewModel(title: "Humidity", detail: String(format: "%@", humidity)))
        models.append(ConditionsDetailCellViewModel(title: "Dewpoint", detail: String(format: "%.0f°", dewpoint)))
        models.append(ConditionsDetailCellViewModel(title: "Pressure", detail: String(format: "%.2f", pressure)))
        models.append(ConditionsDetailCellViewModel(title: "Rainfall (1h)", detail: String(format: "%.0f in", precip_1hr)))

        return models
    }

}
