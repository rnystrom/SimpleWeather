//
//  EmbeddedAdapterSectionController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol EmbeddedAdapterDataSource {
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController
}

class EmbeddedAdapterSectionController: IGListSectionController, IGListSectionType, IGListAdapterDataSource {

    let height: CGFloat
    let dataSource: EmbeddedAdapterDataSource

    var model: EmbeddedSection?

    lazy var adapter: IGListAdapter = {
        let adapter = IGListAdapter(updater: IGListAdapterUpdater(), viewController: self.viewController, workingRangeSize: 0)
        adapter.dataSource = self
        return adapter
    }()

    init(height: CGFloat, dataSource: EmbeddedAdapterDataSource) {
        self.height = height
        self.dataSource = dataSource
        super.init()
    }

    // MARK: IGListSectionType

    func numberOfItems() -> Int {
        return 1
    }

    func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        return CGSize(width: width, height: height)
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let cell = context.dequeueReusableCellFromStoryboard(withIdentifier: "EmbeddedCollectionViewCell", for: self, at: index) as? EmbeddedCollectionViewCell
            else { return UICollectionViewCell() }
        adapter.collectionView = cell.collectionView
        return cell
    }

    func didUpdate(to object: Any) {
        model = object as? EmbeddedSection
        adapter.performUpdates(animated: true)
    }

    func didSelectItem(at index: Int) {}

    // MARK: IGListAdapterDataSource

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return model?.items ?? []
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return dataSource.listAdapter(listAdapter, sectionControllerFor: object)
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }

}
