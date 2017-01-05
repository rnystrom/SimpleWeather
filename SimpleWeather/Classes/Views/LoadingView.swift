//
//  LoadingView.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)

    override init(frame: CGRect) {
        super.init(frame: frame)
        spinner.startAnimating()
        addSubview(spinner)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        spinner.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }

}
