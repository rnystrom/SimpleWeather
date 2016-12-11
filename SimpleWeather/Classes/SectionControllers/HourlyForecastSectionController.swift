//
//  HourlyForecastSectionController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class HourlyForecastSectionController: IGListSectionController, IGListSectionType {

    var viewModel: ForecastHourCellViewModel?

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
    }

    // MARK: IGListSectionType

    func numberOfItems() -> Int {
        return 1
    }

    func sizeForItem(at index: Int) -> CGSize {
        guard let height = collectionContext?.containerSize.height else { return .zero }
        return CGSize(width: height, height: height)
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let viewModel = viewModel,
            let cell = context.dequeueReusableCellFromStoryboard(withIdentifier: "ForecastHourCell", for: self, at: index) as? ForecastHourCell
            else { return UICollectionViewCell() }
        cell.configure(viewModel: viewModel)
        return cell
    }

    func didUpdate(to object: Any) {
        viewModel = object as? ForecastHourCellViewModel
    }

    func didSelectItem(at index: Int) {}

}
