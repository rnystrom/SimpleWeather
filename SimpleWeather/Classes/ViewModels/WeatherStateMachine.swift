//
//  WeatherListAdapterDataSource.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit
import CoreLocation

enum WeatherState {
    case empty
    case forecast(Forecast)
}

class WeatherStateMachine {

    // MARK: Public API

    var state: WeatherState = .empty

    var objects: [IGListDiffable] {
        switch state {
        case let .forecast(forecast):
            return objects(forecast: forecast)
        case .empty:
            return []
        }
    }

    func sectionController(object: Any) -> IGListSectionController {
        if object is ConditionsSection {
            return ConditionsSectionController()
        } else if object is DailyForecastSection {
            return DailyForecastSectionController()
        } else if object is EmbeddedSection {
            return EmbeddedAdapterSectionController(height: 96, dataSource: ForecastHourlyDataSource())
        } else if object is RadarSection {
            return RadarSectionController()
        }
        return IGListSectionController()
    }

    // MARK: Private API

    fileprivate func objects(forecast: Forecast) -> [IGListDiffable] {
        var objects = [IGListDiffable]()

        if let location = forecast.location {
            let radar = RadarSection(
                center: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon),
                width: 1
            )
            objects.append(radar)
        }

        let sortedDaily = forecast.daily?.sorted(by: { $0.date > $1.date })

        if let conditions = ConditionsSection.from(observation: forecast.observation, today: sortedDaily?.first, astronomy: forecast.astronomy) {
            objects.append(conditions)
        }

        if let hourly = EmbeddedSection.from(forecast: forecast) {
            objects.append(hourly)
        }

        if let dailySection = DailyForecastSection.from(forecast: forecast) {
            objects.append(dailySection)
        }
        
        return objects
    }

}
