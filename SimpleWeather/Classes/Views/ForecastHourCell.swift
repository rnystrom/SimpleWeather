//
//  ForecastHourCell.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

class ForecastHourCell: RoundedCollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    func configure(viewModel: ForecastHourCellViewModel) {
        cornerOptions = .all
        timeLabel.text = viewModel.dateString
        tempLabel.attributedText = viewModel.detailsAttributedString
        iconImageView.image = UIImage(named: viewModel.conditionImageName)
    }

}
