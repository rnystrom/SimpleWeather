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

    var model: ConditionsSection?
    var viewModels: [Any]?
    var expanded = false

    let feedbackGenerator = UISelectionFeedbackGenerator()

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func identifier(model: Any) -> String? {
        if model is ConditionsCellViewModel { return "ConditionsCell" }
        else if model is ConditionsDetailCellViewModel { return "ConditionsDetailCell" }
        return nil
    }

    // MARK: IGListSectionType

    func numberOfItems() -> Int {
        return expanded ? (viewModels?.count ?? 0) : 1
    }

    func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        let containedWidth = width - inset.left - inset.right
        let height: CGFloat = index == 0 ? 50 : 25
        return CGSize(width: containedWidth, height: height)
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let viewModel = viewModels?[index],
            let identifier = identifier(model: viewModel)
            else { return UICollectionViewCell() }
        let cell = context.dequeueReusableCellFromStoryboard(withIdentifier: identifier, for: self, at: index)
        if let cell = cell as? ConditionsCell, let viewModel = viewModel as? ConditionsCellViewModel {
            cell.configure(viewModel: viewModel)
            cell.setExpanded(expanded: expanded)
        } else if let cell = cell as? ConditionsDetailCell, let viewModel = viewModel as? ConditionsDetailCellViewModel {
            cell.configure(viewModel: viewModel)
            cell.setIsLast(isLast: index == numberOfItems() - 1)
        }
        return cell
    }

    func didUpdate(to object: Any) {
        model = object as? ConditionsSection
        viewModels = model?.viewModels
    }

    func didSelectItem(at index: Int) {
        guard let cell = collectionContext?.cellForItem(at: 0, sectionController: self) as? ConditionsCell else { return }
        expanded = !expanded
        cell.setExpanded(expanded: expanded, animated: true)

        feedbackGenerator.selectionChanged()

        let indexes = IndexSet(integersIn: 1..<(viewModels?.count ?? 0))
        if expanded {
            collectionContext?.insert(in: self, at: indexes)
        } else {
            collectionContext?.delete(in: self, at: indexes)
        }
    }

}
