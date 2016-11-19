//
//  AppDelegate.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/13/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let nav = window?.rootViewController as? UINavigationController,
            let weatherVC = nav.viewControllers.first as? WeatherViewController {
            weatherVC.session = APISession(key: API_KEY, limiter: RateLimiter(rates: RateLimiter.API_RATES))
        }
        return true
    }

}

