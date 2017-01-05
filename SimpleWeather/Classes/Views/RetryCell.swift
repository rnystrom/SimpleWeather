//
//  RetryCell.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol RetryCellDelegate: class {
    func retryCellDidTapRetry(retryCell: RetryCell)
}

class RetryCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var retryButton: BorderedButton!

    weak var delegate: RetryCellDelegate?

    @IBAction func onRetry(_ sender: Any) {
        delegate?.retryCellDidTapRetry(retryCell: self)
    }
    
}
