//
//  SavedLocationSectionController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/22/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class SavedLocationSectionController: IGListSectionController, IGListSectionType {

    var location: SavedLocation?

    func numberOfItems() -> Int {
        return 1
    }

    func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        return CGSize(width: width, height: 55)
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
        let cell = context.dequeueReusableCellFromStoryboard(withIdentifier: "SavedLocationCell", for: self, at: index) as? SavedLocationCell
            else { return UICollectionViewCell() }
        cell.titleLabel.text = location?.name
        return cell
    }

    func didUpdate(to object: Any) {
        location = object as? SavedLocation
    }

    func didSelectItem(at index: Int) {

    }

}
