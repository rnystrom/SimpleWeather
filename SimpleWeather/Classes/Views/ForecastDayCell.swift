//
//  ForecastDayCell.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/20/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

class ForecastDayCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var highLowConditionsLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    func configure(viewModel: ForecastDayCellViewModel) {
        dayLabel.text = viewModel.dateString
        highLowConditionsLabel.text = viewModel.highLowConditionsString
        iconImageView.image = UIImage(named: viewModel.conditionImageName)
    }

}
