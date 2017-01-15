//
//  SavedLocationSectionController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/22/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import MapKit

class SavedLocationSectionController: IGListSectionController, IGListSectionType, IGListDisplayDelegate {

    var location: SavedLocation?

    override init() {
        super.init()
        displayDelegate = self
//        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    // MARK: IGListSectionType

    func numberOfItems() -> Int {
        return 1
    }

    func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        return CGSize(width: width, height: 180)
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SavedLocationCell.self, for: self, at: index) as? SavedLocationCell
            else { return UICollectionViewCell() }
        return cell
    }

    func didUpdate(to object: Any) {
        location = object as? SavedLocation
    }

    func didSelectItem(at index: Int) {
        guard let controller = viewController?.storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController,
            let location = location
            else { return }
        controller.location = location
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: IGListDisplayDelegate

    func listAdapter(_ listAdapter: IGListAdapter, willDisplay sectionController: IGListSectionController, cell: UICollectionViewCell, at index: Int) {
        guard let cell = cell as? SavedLocationCell,
            let location = location
            else { return }

        // required to force auto layout in cell before setting the region of the map
        // otherwise the region will be set using the frame in the storyboard prototype
        cell.layoutIfNeeded()

        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
            width: 1,
            size: sizeForItem(at: index)
        )
        let viewModel = SavedLocationContentViewModel(text: location.name, userLocation: location.userLocation, region: region)
        cell.locationContentView.configure(viewModel: viewModel)
    }

    func listAdapter(_ listAdapter: IGListAdapter, willDisplay sectionController: IGListSectionController) {}
    func listAdapter(_ listAdapter: IGListAdapter, didEndDisplaying sectionController: IGListSectionController) {}
    func listAdapter(_ listAdapter: IGListAdapter, didEndDisplaying sectionController: IGListSectionController, cell: UICollectionViewCell, at index: Int) {}

}
