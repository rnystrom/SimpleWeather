//
//  Forecast+JSONConvertible.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Forecast: JSONConvertible {

    static func fromJSON(json: [String : Any]) -> Forecast? {
        let conditions: Conditions?
        if let json = json["current_observation"] as? [String: Any] {
            conditions = Conditions.fromJSON(json: json)
        } else {
            conditions = nil
        }

        let location: Location?
        if let json = json["location"] as? [String: Any] {
            location = Location.fromJSON(json: json)
        } else {
            location = nil
        }

        let alerts: [Alert]? = (json["alerts"] as? [ [String: Any] ])?.flatMap({ (json: [String: Any]) in
            return Alert.fromJSON(json: json)
        })

        let daily: [ForecastDay]? = (keypath(dict: json, path: "forecast.simpleforecast.forecastday") as [ [String: Any] ]?)?.flatMap({ (json: [String: Any]) in
            return ForecastDay.fromJSON(json: json)
        })

        let hourly: [ForecastHourly]? = (json["hourly_forecast"] as? [ [String: Any] ])?.flatMap({ (json: [String: Any]) in
            return ForecastHourly.fromJSON(json: json)
        })

        return Forecast(
            location: location,
            conditions: conditions,
            alerts: alerts,
            daily: daily,
            hourly: hourly
        )
    }

}
