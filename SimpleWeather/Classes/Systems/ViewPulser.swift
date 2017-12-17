//
//  ViewPulser.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/26/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

class ViewPulser {

    let view: UIView

    init(view: UIView) {
        self.view = view
        view.isHidden = true
    }

    var enabled = true

    func pulse() {
        guard enabled, !view.isHidden else { return }

        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 0.5
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        let group = CAAnimationGroup()
        group.duration = 2
        group.repeatCount = Float.greatestFiniteMagnitude
        group.animations = [pulseAnimation]

        view.layer.add(group, forKey: "animateOpacity")
    }

    func disable() {
        enabled = false
        view.isHidden = true
        view.layer.removeAllAnimations()
    }

    func enable() {
        enabled = true
        view.isHidden = false
        pulse()
    }

}
