//
//  MKLocalSearchCompletion+IGListDiffable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import MapKit

extension MKLocalSearchCompletion: IGListDiffable {

    public func diffIdentifier() -> NSObjectProtocol {
        return (title + subtitle) as NSString
    }

    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? MKLocalSearchCompletion else { return false }
        return title == object.title
            && subtitle == object.subtitle
    }
    
}
