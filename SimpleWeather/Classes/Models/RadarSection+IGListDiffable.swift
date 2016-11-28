//
//  RadarSection+IGListDiffable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/27/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension RadarSection {

    override func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    override func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return isEqual(object)
    }

}
