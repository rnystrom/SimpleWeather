//
//  ForecastHourlyDataSource.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

class ForecastHourlyDataSource: EmbeddedAdapterDataSource {

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is ForecastHourCellViewModel {
            return HourlyForecastSectionController()
        }
        return IGListSectionController()
    }

}
