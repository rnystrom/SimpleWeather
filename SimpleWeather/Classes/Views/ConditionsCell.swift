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
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    func configure(viewModel: ConditionsCellViewModel) {
        temperatureLabel.text = viewModel.temperatureLabelText
        highLowLabel.text = viewModel.highLowLabelText
        iconImageView.image = UIImage(named: viewModel.conditionImageName)
        feelsLikeLabel.text = viewModel.feelsLikeText
    }
    
}
