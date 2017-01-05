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
    case locationError(LocationError)
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
        case let .locationError(error):
            return [errorViewModel(locationError: error)]
        }
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

    fileprivate func errorViewModel(locationError: LocationError) -> ErrorViewModel {
        let title = NSLocalizedString("Location services error", comment: "")
        let message: String
        switch locationError {
        case .emptyLocation:
            message = NSLocalizedString("Could not find your location. Try again in a minute.", comment: "")
        case .systemDenied:
            message = NSLocalizedString("Location services disabled. Make sure location services are enabled in Settings.app > Privacy > Location Services.", comment: "")
        case .userDenied:
            message = NSLocalizedString("Location services disabled. Find this app in Settings.app > Privacy > Location Services and enable location access.", comment: "")
        case let .error(str):
            message = str
        }
        return ErrorViewModel(title: title, message: message, type: .location)
    }

}
