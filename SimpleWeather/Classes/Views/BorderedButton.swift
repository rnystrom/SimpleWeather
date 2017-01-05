//
//  BorderedButton.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {

    lazy var shapeLayer: CAShapeLayer = {
        let l = CAShapeLayer()
        l.lineWidth = 1
        self.layer.addSublayer(l)
        return l
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
        shapeLayer.strokeColor = tintColor.cgColor
    }

}
