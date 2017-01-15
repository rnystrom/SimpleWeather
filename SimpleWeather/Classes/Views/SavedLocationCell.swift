//
//  SavedLocationCell.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/18/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol SavedLocationCellDelegate: class {
    func didSelectSavedLocation(cell: SavedLocationCell)
    func didDeleteSavedLocation(cell: SavedLocationCell)
}

class SavedLocationCell: UICollectionViewCell, UIScrollViewDelegate {

    let locationContentView = SavedLocationContentView()
    let actionView = SavedLocationDeleteView()

    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceHorizontal = true
        view.alwaysBounceVertical = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.scrollsToTop = false
        view.backgroundColor = .clear
        return view
    }()

    var delegate: SavedLocationCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(scrollView)

        scrollView.delegate = self
        scrollView.addSubview(locationContentView)
        scrollView.addSubview(actionView)

        locationContentView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(SavedLocationCell.didTapLocationContentView(sender:))
        ))
        actionView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(SavedLocationCell.didTapActionView(sender:))
        ))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let insets: CGFloat = 15
        scrollView.contentSize = CGSize(width: bounds.width + 80, height: bounds.height)
        scrollView.frame = contentView.bounds
        locationContentView.frame = scrollView.bounds.insetBy(dx: insets, dy: 8)

        var actionFrame = bounds
        actionFrame.origin.x = scrollView.bounds.width
        actionFrame.size.width = scrollView.contentSize.width - scrollView.frame.width - insets
        actionView.frame = actionFrame
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.contentOffset = .zero
    }

    // MARK: Public API

    func configure(viewModel: SavedLocationCellViewModel) {
        // disable "delete" reveal for user location
        scrollView.isScrollEnabled = !viewModel.userLocation
        locationContentView.label.text = viewModel.text
        locationContentView.mapView.region = locationContentView.mapView.regionThatFits(viewModel.region)
        locationContentView.mapView.userTrackingMode = viewModel.userLocation ? .follow : .none
    }

    // MARK: Private API

    var actionWidth: CGFloat {
        return scrollView.contentSize.width - scrollView.bounds.width
    }

    func actionPercentVisible(x: CGFloat) -> CGFloat {
        return min(x / actionWidth, 1)
    }

    func didTapLocationContentView(sender: Any) {
        if actionPercentVisible(x: scrollView.contentOffset.x) >= 1 {
            scrollView.setContentOffset(.zero, animated: true)
        } else {
            delegate?.didSelectSavedLocation(cell: self)
        }
    }

    func didTapActionView(sender: Any) {
        delegate?.didDeleteSavedLocation(cell: self)
    }

    // MARK: UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha: CGFloat
        let percentVisible = actionPercentVisible(x: scrollView.contentOffset.x)
        if percentVisible > 0 {
            alpha = 1 - percentVisible * 0.5
        } else {
            alpha = 1
        }
        locationContentView.alpha = alpha
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let percentVisible = actionPercentVisible(x: targetContentOffset.pointee.x)

        let x: CGFloat
        if percentVisible > 0.5 {
            x = actionWidth
        } else {
            x = 0
        }
        targetContentOffset.pointee.x = x
    }

}
