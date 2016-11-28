//
//  RadarOverlayView.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/27/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import MapKit

class RadarOverlayView: MKOverlayRenderer {

    let image: UIImage

    init(overlay: MKOverlay, image: UIImage) {
        self.image = image
        super.init(overlay: overlay)
    }

    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        // https://www.raywenderlich.com/87008/overlay-views-mapkit-swift-tutorial
        guard let imageRef = image.cgImage else { return }
        let theMapRect = overlay.boundingMapRect
        let theRect = rect(for: theMapRect)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0.0, y: -theRect.size.height)
        context.setAlpha(0.5)
        context.draw(imageRef, in: theRect)
    }

}
