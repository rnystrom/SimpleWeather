//
//  SavedLocation+IGListDiffable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/18/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension SavedLocation: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return name as NSString
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let rhs = object as? SavedLocation else { return false }
        return name == rhs.name && latitude == rhs.latitude && longitude == rhs.longitude
    }

}
