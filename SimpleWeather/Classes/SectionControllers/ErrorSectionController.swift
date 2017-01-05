//
//  ErrorSectionController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol ErrorSectionControllerDelegate: class {
    func errorSectionControllerDidTapRetry(errorSectionController: ErrorSectionController)
}

class ErrorSectionController: IGListSectionController, IGListSectionType, RetryCellDelegate {

    weak var delegate: ErrorSectionControllerDelegate?
    var model: ErrorViewModel?

    // MARK: IGListSectionType

    func numberOfItems() -> Int {
        return 1
    }

    func sizeForItem(at index: Int) -> CGSize {
        return collectionContext?.containerSize ?? CGSize()
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: "RetryCell", for: self, at: index) as? RetryCell
            else { return UICollectionViewCell() }
        cell.delegate = self
        cell.titleLabel.text = model?.title
        cell.messageLabel.text = model?.message
        return cell
    }

    func didUpdate(to object: Any) {
        model = object as? ErrorViewModel
    }

    func didSelectItem(at index: Int) {}

    // MARK: RetryCellDelegate

    func retryCellDidTapRetry(retryCell: RetryCell) {
        delegate?.errorSectionControllerDidTapRetry(errorSectionController: self)
    }

}
