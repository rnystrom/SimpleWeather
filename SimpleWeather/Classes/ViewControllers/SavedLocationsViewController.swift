//
//  SavedLocationsViewController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/18/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class SavedLocationsViewController: UIViewController, IGListAdapterDataSource, SavedLocationStoreListener {
    
    @IBOutlet weak var collectionView: IGListCollectionView!

    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var store: SavedLocationStore?

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = collectionView
        adapter.dataSource = self

        store?.add(listener: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController,
            let controller = nav.viewControllers.first as? SearchViewController {
            controller.store = store
        }
    }

    // MARK: IGListAdapterDataSource

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return store?.locations ?? []
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return SavedLocationSectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }

    // MARK: SavedLocationStoreListener

    func storeDidUpdate(store: SavedLocationStore) {
        adapter.performUpdates(animated: true)
    }

}
