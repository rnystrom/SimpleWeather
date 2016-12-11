//
//  ForecastDayCell.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/20/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

class ForecastDayCell: RoundedCollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var highLowConditionsLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var precipLabel: UILabel!

    func configure(viewModel: ForecastDayCellViewModel) {
        dayLabel.text = viewModel.dateString
        highLowConditionsLabel.attributedText = viewModel.highLowConditionsString
        iconImageView.image = UIImage(named: viewModel.conditionImageName)

        switch viewModel.position {
        case .top: cornerOptions = .top
        case .bottom: cornerOptions = .bottom
        case .none: cornerOptions = []
        }

        if let precip = viewModel.precipString {
            precipLabel.isHidden = false
            precipLabel.text = precip
        } else {
            precipLabel.isHidden = true
        }
    }

}
