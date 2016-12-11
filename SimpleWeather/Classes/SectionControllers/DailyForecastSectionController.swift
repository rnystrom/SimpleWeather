//
//  DailyForecastSectionController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/20/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class DailyForecastSectionController: IGListSectionController, IGListSectionType {

    var model: DailyForecastSection?

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    // MARK: IGListSectionType

    func numberOfItems() -> Int {
        return model?.viewModels.count ?? 0
    }

    func sizeForItem(at index: Int) -> CGSize {
        guard let size = collectionContext?.containerSize else { return .zero }
        return CGSize(width: size.width - inset.left - inset.right, height: 35)
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let viewModel = model?.viewModels[index],
            let cell = context.dequeueReusableCellFromStoryboard(withIdentifier: "ForecastDayCell", for: self, at: index) as? ForecastDayCell
            else { return UICollectionViewCell() }
        cell.configure(viewModel: viewModel)
        return cell
    }

    func didUpdate(to object: Any) {
        model = object as? DailyForecastSection
    }

    func didSelectItem(at index: Int) {}

}
