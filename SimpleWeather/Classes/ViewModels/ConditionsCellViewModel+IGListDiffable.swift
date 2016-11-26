//
//  ConditionsCellViewModel+IGListDiffable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/20/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension ConditionsCellViewModel: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return temperature as NSNumber
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let rhs = object as? ConditionsCellViewModel else { return false }
        return temperature == rhs.temperature
        && high == rhs.high
        && low == rhs.low
        && conditionImageName == rhs.conditionImageName
    }

}
