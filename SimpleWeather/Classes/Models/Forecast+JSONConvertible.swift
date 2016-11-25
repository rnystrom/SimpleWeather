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
        let observation: Observation?
        if let json = json["current_observation"] as? [String: Any] {
            observation = Observation.fromJSON(json: json)
        } else {
            observation = nil
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

        let astronomy: Astronomy?
        if let json = json["moon_phase"] as? [String: Any] {
            astronomy = Astronomy.fromJSON(json: json)
        } else {
            astronomy = nil
        }

        return Forecast(
            location: location,
            observation: observation,
            alerts: alerts,
            daily: daily,
            hourly: hourly,
            astronomy: astronomy
        )
    }

}
