//
//  ConditionsDetailCell.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/11/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

class ConditionsDetailCell: RoundedCollectionViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    func configure(viewModel: ConditionsDetailCellViewModel) {
        titleLabel.text = viewModel.title
        detailLabel.text = viewModel.detail
    }

    func setIsLast(isLast: Bool) {
        cornerOptions = isLast ? .bottom : []
    }

}
