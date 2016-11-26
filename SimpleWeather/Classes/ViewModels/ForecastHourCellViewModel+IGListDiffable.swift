//
//  ForecastHourCellViewModel+IGListDiffable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension ForecastHourCellViewModel: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return date as NSDate
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? ForecastHourCellViewModel else { return false }
        return date == object.date && temp == object.temp && conditionImageName == object.conditionImageName
    }

}
