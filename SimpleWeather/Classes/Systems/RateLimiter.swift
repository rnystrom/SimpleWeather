//
//  RateLimitedSession.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/15/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

class RateLimiter {

    struct Rate {
        let rate: Double
        let per: Double
    }

    // rates based on API_KEY plan
    static let API_RATES = [
        Rate(rate: 10, per: 60.0), // 10 per minute
        Rate(rate: 500, per: (24.0*60.0*60.0)) // 500 per day
    ]

    let rates: [Rate]
    lazy var allowance: [Double] = { return self.rates.map { $0.rate } }()
    var last = CFAbsoluteTimeGetCurrent()

    init(rates: [Rate]) {
        self.rates = rates
    }

    func attempt() -> Bool {
        let current = CFAbsoluteTimeGetCurrent()
        let delta = current - last
        last = current

        var canExecute = true
        for (i, r) in rates.enumerated() {
            var bucket = allowance[i] + delta * (r.rate / r.per)
            if bucket > r.rate {
                bucket = r.rate
            }
            if bucket - 1.0 <= 1.0 {
                canExecute = false
            }
            allowance[i] = bucket
        }

        if canExecute {
            for (i, _) in allowance.enumerated() {
                allowance[i] -= 1
            }
        }

        return canExecute
    }

}
