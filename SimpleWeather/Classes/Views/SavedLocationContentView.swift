//
//  SavedLocationContentView.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import MapKit

class SavedLocationContentView: UIView {

    let mapView: MKMapView = {
        let view = MKMapView()
        view.showsScale = false
        view.showsCompass = false
        view.showsTraffic = false
        view.showsBuildings = false
        view.showsUserLocation = false
        view.showsPointsOfInterest = false
        view.isUserInteractionEnabled = false
        return view
    }()

    let label: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textColor = .white
        view.backgroundColor = .clear
        return view
    }()

    let disclosure = UIImageView(image: #imageLiteral(resourceName: "Disclosure"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        clipsToBounds = true
        addSubview(mapView)
        addSubview(label)
        addSubview(disclosure)
        backgroundColor = UIColor(red: 30/255.0, green: 32/255.0, blue: 41/255.0, alpha: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let divide = bounds.divided(atDistance: 40, from: .minYEdge)
        label.frame = divide.slice.insetBy(dx: 15, dy: 0)
        mapView.frame = divide.remainder
        disclosure.center = CGPoint(x: bounds.width - disclosure.bounds.width / 2 - 15, y: label.center.y)
    }

}
