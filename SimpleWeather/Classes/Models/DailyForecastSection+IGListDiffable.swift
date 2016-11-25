//
//  DailyForecastSection+IGListDiffable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/20/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension DailyForecastSection: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return "daily" as NSString
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? DailyForecastSection else { return false }
        return viewModels == object.viewModels
    }

}
