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
            session?.getForecastForCurrentLocation(completion: { (forecast: Forecast?, error: Error?) in
                self.title = forecast?.location?.city
                print(error)
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
