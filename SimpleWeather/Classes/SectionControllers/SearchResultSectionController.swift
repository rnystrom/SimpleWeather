//
//  SearchResultSectionController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import MapKit

func SearchResultSectionController() -> IGListSingleSectionController {
    let configureBlock = { (item: Any, cell: UICollectionViewCell) in
        guard let cell = cell as? SearchResultCell,
            let result = item as? MKLocalSearchCompletion else { return }
        cell.label.text = result.title

        cell.detailLabel.text = result.subtitle
        if result.subtitle.characters.count > 0 {
            cell.labelVerticalConstraint.constant = -6
        } else {
            cell.labelVerticalConstraint.constant = 0
        }
    }

    let sizeBlock = { (item: Any, context: IGListCollectionContext?) -> CGSize in
        guard let context = context else { return CGSize() }
        return CGSize(width: context.containerSize.width, height: 55)
    }
    return IGListSingleSectionController(
        storyboardCellIdentifier: "SearchResultCell",
        configureBlock: configureBlock,
        sizeBlock: sizeBlock
    )

}
