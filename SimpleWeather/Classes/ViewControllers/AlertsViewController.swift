//
//  AlertsViewController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/26/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

class AlertsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    var alerts: [Alert]?

    override func viewDidLoad() {
        super.viewDidLoad()
        let descriptions: [String]? = alerts?.flatMap({ $0.message })
        textView.text = descriptions?.joined(separator: "\n")
    }

}
