//
//  ConditionsCell.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

class ConditionsCell: UICollectionViewCell {
    
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var highLowLabel: UILabel!

    func configure(viewModel: ConditionsCellViewModel) {
        temperatureLabel.text = String(format: "%s %zi°", viewModel.conditionsEmoji, viewModel.temperature)
        highLowLabel.text = String(format: "%zi° / %zi°", viewModel.high, viewModel.low)
    }
    
}
