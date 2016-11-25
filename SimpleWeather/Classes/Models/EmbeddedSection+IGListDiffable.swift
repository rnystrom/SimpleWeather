//
//  EmbeddedSection+IGListDiffable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension EmbeddedSection: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return identifier
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? EmbeddedSection else { return false }
        return identifier.isEqual(object.identifier)
    }

}
