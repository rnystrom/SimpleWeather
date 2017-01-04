//
//  RadarSectionController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/27/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import MapKit

func configure(mapView: MKMapView, region: MKCoordinateRegion) {
    mapView.removeOverlays(mapView.overlays)
    mapView.add(RadarOverlay(coordinate: region.center, boundingMapRect: region.mapRect))
}

class RadarSectionController: IGListSectionController, IGListSectionType, IGListDisplayDelegate, MKMapViewDelegate {

    override init() {
        super.init()
        displayDelegate = self
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
    }

    var model: RadarSection?
    var radarImage: UIImage?
    var task: URLSessionDataTask?

    deinit {
        task?.cancel()
    }

    // MARK: Private API

    func loadRadar(region: MKCoordinateRegion, size: CGSize) {
        let bounds = region.bounds

        guard let url = WundergroundRadarURL(
            apiKey: API_KEY,
            minLat: Double(bounds.origin.x),
            maxLat: Double(bounds.maxX),
            minLon: Double(bounds.origin.y),
            maxLon: Double(bounds.maxY),
            width: Double(size.width),
            height: Double(size.height)
            )
            else { return }

        let request = URLSessionDataTaskResponse(serializeJSON: false) { (data: Any) -> UIImage? in
            guard let data = data as? Data else { return nil }
            return UIImage(data: data)
        }

        task = URLSession.shared.fetch(url: url, request: request) { [weak self] (result: URLSessionResult) in
            switch result {
            case let .success(image):
                guard let myself = self,
                    let context = myself.collectionContext,
                    let mapView = (context.cellForItem(at: 0, sectionController: myself) as? MapCell)?.mapView
                    else { return }

                myself.radarImage = image
                configure(mapView: mapView, region: region)
            case .failure(_): break;
            }
        }
    }

    // MARK: IGListSectionType

    func numberOfItems() -> Int {
        return 1
    }

    func sizeForItem(at index: Int) -> CGSize {
        guard let size = collectionContext?.containerSize else { return .zero }
        return CGSize(width: size.width, height: 200)
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let cell = context.dequeueReusableCellFromStoryboard(withIdentifier: "MapCell", for: self, at: index) as? MapCell
            else { return UICollectionViewCell() }
        cell.mapView.delegate = self
        return cell
    }

    func didUpdate(to object: Any) {
        model = object as? RadarSection
    }

    func didSelectItem(at index: Int) {}

    // MARK: IGListDisplayDelegate

    func listAdapter(_ listAdapter: IGListAdapter, willDisplay sectionController: IGListSectionController, cell: UICollectionViewCell, at index: Int) {
        guard let cell = cell as? MapCell,
            let mapView = cell.mapView,
            let model = model
            else { return }

        // required to force auto layout in cell before setting the region of the map
        // otherwise the region will be set using the frame in the storyboard prototype
        cell.layoutIfNeeded()

        let region = mapView.regionThatFits(model.region(cell.bounds.size))
        configure(mapView: mapView, region: region)
        mapView.region = region
    }

    func listAdapter(_ listAdapter: IGListAdapter, willDisplay sectionController: IGListSectionController) {}
    func listAdapter(_ listAdapter: IGListAdapter, didEndDisplaying sectionController: IGListSectionController) {}
    func listAdapter(_ listAdapter: IGListAdapter, didEndDisplaying sectionController: IGListSectionController, cell: UICollectionViewCell, at index: Int) {}

    // MARK: MKMapViewDelegate

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let size = sizeForItem(at: 0)
        loadRadar(region: mapView.region, size: size)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let image = radarImage, overlay is RadarOverlay {
            return RadarOverlayView(overlay: overlay, image: image)
        }
        return MKOverlayRenderer()
    }

}
