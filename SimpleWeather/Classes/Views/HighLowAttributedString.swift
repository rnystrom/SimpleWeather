//
//  HighLowAttributedString.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/27/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

func highLowAttributedString(high: Int, low: Int, size: CGFloat = 15) -> NSAttributedString {
    let font = UIFont.systemFont(ofSize: size, weight: UIFontWeightMedium)
    let mstr = NSMutableAttributedString(
        string: String(format: "%zi°", high),
        attributes: [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: UIColor.white
        ])
    mstr.append(NSAttributedString(
        string: String(format: " %zi°", low),
        attributes: [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: UIColor.lightGray
        ]))
    return mstr
}
