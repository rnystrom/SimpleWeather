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

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    // MARK: IGListSectionType

    func numberOfItems() -> Int {
        return 1
    }

    func sizeForItem(at index: Int) -> CGSize {
        guard let size = collectionContext?.containerSize else { return .zero }
        return CGSize(width: size.width - inset.left - inset.right, height: 50)
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let viewModel = viewModel,
            let cell = context.dequeueReusableCellFromStoryboard(withIdentifier: "ConditionsCell", for: self, at: index) as? ConditionsCell
            else { return UICollectionViewCell() }
        cell.configure(viewModel: viewModel)
        cell.cornerOptions = .all
        return cell
    }

    func didUpdate(to object: Any) {
        viewModel = object as? ConditionsCellViewModel
    }

    func didSelectItem(at index: Int) {
        guard let cell = collectionContext?.cellForItem(at: 0, sectionController: self) as? ConditionsCell else { return }
        cell.setExpanded(expanded: true, animated: true)
    }

}
