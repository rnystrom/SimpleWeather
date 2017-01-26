//
//  AppDelegate.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/13/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

// A bogus comment
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let savedLocationStore = SavedLocationStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let nav = window?.rootViewController as? UINavigationController,
            let controller = nav.viewControllers.first as? SavedLocationsViewController {
            controller.store = savedLocationStore
        }
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        savedLocationStore.save()
    }

}

