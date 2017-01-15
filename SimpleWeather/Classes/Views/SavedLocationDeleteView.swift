//
//  SavedLocationDeleteView.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class SavedLocationDeleteView: UIView {

    let label: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.text = NSLocalizedString("Delete", comment: "")
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 13)
        view.sizeToFit()
        return view
    }()

    let imageView = UIImageView(image: #imageLiteral(resourceName: "Delete"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let height = imageView.bounds.height + 8 + label.bounds.height
        imageView.center = CGPoint(x: bounds.midX, y: (bounds.height - height + imageView.bounds.height) / 2)
        label.center = CGPoint(x: bounds.midX, y: (bounds.height + height - label.bounds.height) / 2)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        alpha = 0.5
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        alpha = 1
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        alpha = 1
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        alpha = 1
    }

}
