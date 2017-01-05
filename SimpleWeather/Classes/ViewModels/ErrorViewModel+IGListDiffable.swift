//
//  ErrorViewModel+IGListDiffable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

extension ErrorViewModel: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return title as NSString
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? ErrorViewModel else { return false }
        return type == object.type
        && title == object.title
        && message == object.message
    }

}
