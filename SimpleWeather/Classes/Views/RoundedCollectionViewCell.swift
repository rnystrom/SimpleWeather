//
//  RoundedCollectionView.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/9/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

struct CornerOptions: OptionSet {
    let rawValue: Int
    static let topLeft = CornerOptions(rawValue: 1 << 0)
    static let topRight = CornerOptions(rawValue: 1 << 1)
    static let bottomLeft = CornerOptions(rawValue: 1 << 2)
    static let bottomRight = CornerOptions(rawValue: 1 << 3)

    static let top: CornerOptions = [.topLeft, .topRight]
    static let bottom: CornerOptions = [.bottomLeft, .bottomRight]
    static let all: CornerOptions = [.topLeft, .topRight, .bottomLeft, .bottomRight]
}

extension CGRect {

    var topLeft: CGPoint {
        return origin
    }

    var topRight: CGPoint {
        return CGPoint(x: maxX, y: minY)
    }

    var bottomRight: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }

    var bottomLeft: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }

}

public class RoundedCollectionViewCell : UICollectionViewCell {

    var cornerOptions: CornerOptions = [] {
        didSet {
            setNeedsUpdateMask()
        }
    }

    lazy var roundedCornerMask: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.mask = layer
        return layer
    }()

    var needsUpdateMask = true
    func setNeedsUpdateMask() {
        needsUpdateMask = true
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updateMask()
    }

    func updateMask() {
        guard needsUpdateMask else { return }
        needsUpdateMask = true

        let radius: CGFloat = 8
        let innerBounds = bounds.insetBy(dx: radius, dy: radius)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.height / 2.0))

        if cornerOptions.contains(.topLeft) {
            path.addArc(
                withCenter: innerBounds.topLeft,
                radius: radius,
                startAngle: CGFloat.pi,
                endAngle: 3.0 * CGFloat.pi / 2.0,
                clockwise: true
            )
        } else {
            path.addLine(to: bounds.topLeft)
        }

        if cornerOptions.contains(.topRight) {
            path.addArc(
                withCenter: innerBounds.topRight,
                radius: radius,
                startAngle: 3.0 * CGFloat.pi / 2.0,
                endAngle: 0,
                clockwise: true
            )
        } else {
            path.addLine(to: bounds.topRight)
        }

        if cornerOptions.contains(.bottomRight) {
            path.addArc(
                withCenter: innerBounds.bottomRight,
                radius: radius,
                startAngle: 0,
                endAngle: CGFloat.pi / 2.0,
                clockwise: true
            )
        } else {
            path.addLine(to: bounds.bottomRight)
        }

        if cornerOptions.contains(.bottomLeft) {
            path.addArc(
                withCenter: innerBounds.bottomLeft,
                radius: radius,
                startAngle: CGFloat.pi / 2.0,
                endAngle: CGFloat.pi,
                clockwise: true
            )
        } else {
            path.addLine(to: bounds.bottomLeft)
        }
        
        roundedCornerMask.path = path.cgPath
    }

}
