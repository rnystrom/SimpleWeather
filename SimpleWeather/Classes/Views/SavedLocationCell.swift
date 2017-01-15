//
//  SavedLocationCell.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/18/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

class SavedLocationCell: UICollectionViewCell {

    let locationContentView = SavedLocationContentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(locationContentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        locationContentView.frame = contentView.bounds.insetBy(dx: 15, dy: 8)
    }

}
