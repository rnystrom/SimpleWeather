//
//  ConditionsSectionController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class ConditionsSectionController: IGListSectionController, IGListSectionType {

    var viewModel: ConditionsCellViewModel?

    func numberOfItems() -> Int {
        return 1
    }

    func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        return CGSize(width: context.containerSize.width, height: 70)
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let viewModel = viewModel,
            let cell = context.dequeueReusableCellFromStoryboard(withIdentifier: "ConditionsCell", for: self, at: index) as? ConditionsCell
            else { return UICollectionViewCell() }
        cell.configure(viewModel: viewModel)
        return cell
    }

    func didUpdate(to object: Any) {
        viewModel = object as? ConditionsCellViewModel
    }

    func didSelectItem(at index: Int) {}

}
