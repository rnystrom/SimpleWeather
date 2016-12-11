//
//  ConditionsSection+IGListDiffable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/11/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension ConditionsSection: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return (description + date.description) as NSString
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let rhs = object as? ConditionsSection else { return false }
        return temperature == rhs.temperature
            && high == rhs.high
            && low == rhs.low
            && condition == rhs.condition
            && feelsLike == rhs.feelsLike
            && wind == rhs.wind
            && date == rhs.date
            && humidity == rhs.humidity
            && dewpoint == rhs.dewpoint
            && pressure == rhs.pressure
            && visibility == rhs.visibility
            && precip_1hr == rhs.precip_1hr
            && description == rhs.description
            && timeOfDay == rhs.timeOfDay
    }
    
}
