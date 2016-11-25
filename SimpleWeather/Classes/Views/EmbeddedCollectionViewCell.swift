//
//  EmbeddedCollectionViewCell.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class EmbeddedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: IGListCollectionView! {
        didSet {
            collectionView.bounces = true
            collectionView.alwaysBounceVertical = false
            collectionView.alwaysBounceHorizontal = true
        }
    }
    
}
