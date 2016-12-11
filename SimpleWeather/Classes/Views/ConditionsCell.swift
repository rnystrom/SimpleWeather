//
//  ConditionsCell.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

class ConditionsCell: RoundedCollectionViewCell {
    
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var highLowLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var arrowImageView: UIImageView!

    func configure(viewModel: ConditionsCellViewModel) {
        cornerOptions = .all
        temperatureLabel.text = viewModel.temperatureLabelText
        highLowLabel.attributedText = viewModel.highLowLabelText
        iconImageView.image = UIImage(named: viewModel.conditionImageName)
        feelsLikeLabel.text = viewModel.feelsLikeText
    }

    func setExpanded(expanded: Bool, animated: Bool = false) {
        cornerOptions = expanded ? .top : .all
        updateMaskIfNeeded()

        let color: UIColor
        if expanded {
            color = UIColor(red: 53/255.0, green: 55/255.0, blue: 63/255.0, alpha: 1)
        } else {
            color = UIColor(red: 30/255.0, green: 32/255.0, blue: 41/255.0, alpha: 1)
        }
        backgroundColor = color

        UIView.animate(
            withDuration: (animated ? 0.8 : 0),
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0,
            options: [],
            animations: {
            self.arrowImageView.transform = expanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
        })
    }
    
}
