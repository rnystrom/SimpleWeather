//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/13/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var session: APISession? {
        didSet {
            session?.getForecast(lat: 47.1, lon: -74, completion: { (forecast: Forecast?, error: Error?) in
                self.title = forecast?.location?.city
            })
        }
    }

    var forecast: Forecast? {
        didSet {
            title = forecast?.location?.city
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
