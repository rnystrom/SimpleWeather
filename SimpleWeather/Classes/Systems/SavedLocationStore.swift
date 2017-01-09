//
//  SavedLocationStore.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/22/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol SavedLocationStoreListener: class {
    func storeDidUpdate(store: SavedLocationStore)
}

class SavedLocationStore {

    fileprivate let listeners = NSHashTable<AnyObject>.weakObjects()

    fileprivate let filePath: String? = {
        guard let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            else { return nil }
        return URL(string: documents)?.appendingPathComponent("saved_location.store").absoluteString
    }()

    lazy private(set) var locations: [SavedLocation] = {
        if let filePath = self.filePath,
            let locations = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [SavedLocation] {
            return locations
        } else {
            return [
                SavedLocation(name: "Your Location", latitude: 0, longitude: 0, userLocation: true),
                SavedLocation(name: "New York, NY", latitude: 40.7128, longitude: -74.0059, userLocation: false),
                SavedLocation(name: "San Francisco, CA", latitude: 37.7749, longitude: -122.4194, userLocation: false),
            ]
        }
    }()

    func save() {
        guard let filePath = filePath else { return }
        NSKeyedArchiver.archiveRootObject(locations, toFile: filePath)
    }

    func add(listener: SavedLocationStoreListener) {
        listeners.add(listener)
    }

    func remove(listener: SavedLocationStoreListener) {
        listeners.remove(listener)
    }

    func add(location: SavedLocation) {
        guard locations.index(of: location) == nil else { return }
        locations.append(location)
    }

    func remove(location: SavedLocation) {
        if let index = locations.index(of: location) {
            locations.remove(at: index)
        }
    }

}
