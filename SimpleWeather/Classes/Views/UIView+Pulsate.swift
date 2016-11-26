//
//  UIView+Pulsate.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/26/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension UIView {

    func pulsate() {
        guard !isHidden else { return }

        let appear = alpha < 1

        UIView.animate(
            withDuration: 0.5,
            delay: appear ? 0 : 0.5,
            options: [],
            animations: {
                self.alpha = appear ? 1 : 0
        }, completion: { [weak self] (_: Bool) in
            self?.pulsate()
        })
    }

}
