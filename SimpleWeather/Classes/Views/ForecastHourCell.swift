//
//  ForecastHourCell.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

class ForecastHourCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!

    func configure(viewModel: ForecastHourCellViewModel) {
        timeLabel.text = viewModel.dateString
        emojiLabel.text = viewModel.conditionsEmoji
        tempLabel.text = viewModel.tempString
    }

}
