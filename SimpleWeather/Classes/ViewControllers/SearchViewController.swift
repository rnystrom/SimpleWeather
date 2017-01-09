//
//  SearchViewController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import MapKit

class SearchViewController: UIViewController,
UISearchBarDelegate,
IGListAdapterDataSource,
MKLocalSearchCompleterDelegate,
IGListSingleSectionControllerDelegate {

    @IBOutlet weak var collectionView: IGListCollectionView!

    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var store: SavedLocationStore?

    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.showsCancelButton = true
        bar.sizeToFit()
        bar.delegate = self
        bar.tintColor = .white
        bar.placeholder = NSLocalizedString("Search for locations", comment: "")
        return bar
    }()

    lazy var searchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        completer.filterType = .locationsAndQueries
        return completer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()

        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    // MARK: UISearchBarDelegate

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }

    // MARK: MKLocalSearchCompleterDelegate

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        adapter.performUpdates(animated: true)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {

    }

    // MARK: IGListAdapterDataSource

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return searchCompleter.results
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        let controller = SearchResultSectionController()
        controller.selectionDelegate = self
        return controller
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }

    // MARK: IGListSingleSectionControllerDelegate

    func didSelect(_ sectionController: IGListSingleSectionController) {
        guard let object = adapter.object(for: sectionController) as? MKLocalSearchCompletion else { return }
        let searchRequest = MKLocalSearchRequest(completion: object)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let coordinate = response?.mapItems.first?.placemark.coordinate {
                let location = SavedLocation(
                    name: object.title,
                    latitude: coordinate.latitude, 
                    longitude: coordinate.longitude,
                    userLocation: false
                )
                self.store?.add(location: location)
            } else {
                let alert = UIAlertController(
                    title: NSLocalizedString("Error", comment: ""),
                    message: NSLocalizedString("There was a problem saving the location.", comment: ""),
                    preferredStyle: .alert
                )
                let action = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }

}
