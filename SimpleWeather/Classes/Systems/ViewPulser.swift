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

    var pulsing = false
    var enabled = true

    func pulse() {
        guard !pulsing, enabled, !view.isHidden else { return }

        pulsing = true
        let appear = view.alpha < 1

        UIView.animate(
            withDuration: 0.5,
            delay: appear ? 0 : 0.5,
            options: [],
            animations: { [weak self] in
                self?.view.alpha = appear ? 1 : 0
        }, completion: { [weak self] (finished: Bool) in
            self?.pulsing = false
            self?.pulse()
        })
    }

    func disable() {
        enabled = false
        view.isHidden = true
    }

    func enable() {
        enabled = true
        view.isHidden = false
        pulse()
    }

}
