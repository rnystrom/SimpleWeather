//
//  ConditionsSectionTests.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest

class ConditionsSectionTests: XCTestCase {

    func day(date: Date, high: Int, low: Int) -> ForecastDay {
        return ForecastDay(
            date: date,
            high: high,
            low: low,
            description: "description",
            pop: 0.3,
            qpf_allday: 0.4,
            qpf_day: 0.5,
            qpf_night: 0.6,
            snow_allday: 0.7,
            snow_day: 0.8,
            snow_night: 0.9,
            avehumidity: 10,
            maxhumidity: 11,
            minhumidity: 12,
            condition: .clear,
            max_wind: nil,
            average_wind: nil
        )
    }

    func observation(date: Date) -> Observation {
        return Observation(
            date: date,
            weather: "weather",
            temp: 1,
            humidity: "humidity",
            wind: Wind(speed: 2, direction: "direction"),
            pressure: 3,
            dewpoint: 4,
            feelslike: 5,
            visibility: 6,
            uvi: 7,
            precip_1hr: 8,
            precip_day: 9,
            condition: .clear
        )
    }

    func astronomy() -> Astronomy {
        return Astronomy(
            sunrise: Date(),
            sunset: Date(),
            moonrise: Date(),
            moonset: Date(),
            moonIllumination: 0.1,
            moonAge: 2,
            moonPhaseDescription: "moon phase",
            moonHemisphere: "moon hemi"
        )
    }

    func test_whenCreatingConditions_thatHighTempCorrect() {
        let today = Date()
        let daily = [
            day(date: today, high: 2, low: 1),
            day(date: today.addingTimeInterval(1*24*60*60), high: 4, low: 3),
            day(date: today.addingTimeInterval(2*24*60*60), high: 6, low: 5),
        ]
        let forecast = Forecast(
            location: nil,
            observation: observation(date: today),
            alerts: nil,
            daily: daily,
            hourly: nil,
            astronomy: astronomy()
        )
        let conditionsSection = ConditionsSection.from(forecast: forecast)
        XCTAssertEqual(conditionsSection?.high, 2)
        XCTAssertEqual(conditionsSection?.low, 1)
    }
    
}
