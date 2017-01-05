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
    case fetchError(FetchError)
    case forecast(Forecast)
}

class WeatherStateMachine {

    // MARK: Public API

    var state: WeatherState = .empty

    var objects: [IGListDiffable] {
        switch state {
        case .empty:
            return []
        case let .forecast(forecast):
            return objects(forecast: forecast)
        case let .fetchError(error):
            return [errorViewModel(fetchError: error)]
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

    fileprivate func errorViewModel(fetchError: FetchError) -> ErrorViewModel {
        let title = NSLocalizedString("Something went wrong", comment: "")
        let message: String
        switch fetchError {
        case .emptyResponse:
            message = NSLocalizedString("The data is missing. Try again in a minute.", comment: "")
        case .jsonCast:
            message = NSLocalizedString("Weather data was returned in the wrong format.", comment: "")
        case let .json(str):
            message = str
        case let .network(str):
            message = str
        case .parsing:
            message = NSLocalizedString("Weather data was corrupted.", comment: "")
        }
        return ErrorViewModel(title: title, message: message, type: .network)
    }

}
