//: Playground - noun: a place where people can play

import UIKit
import MapKit
import PlaygroundSupport

class ContentView: UIView {

    let mapView: MKMapView = {
        let view = MKMapView()
        view.showsScale = false
        view.showsCompass = false
        view.showsTraffic = false
        view.showsBuildings = false
        view.showsUserLocation = false
        view.showsPointsOfInterest = false
        view.backgroundColor = .orange
        return view
    }()

    let label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17)
        view.textColor = .white
        view.backgroundColor = .purple
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 4
        clipsToBounds = true
        addSubview(mapView)
        addSubview(label)
        backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let divide = bounds.divided(atDistance: 40, from: .minYEdge)
        label.frame = divide.slice.insetBy(dx: 15, dy: 0)
        mapView.frame = divide.remainder
    }

    func configure(text: String) {
        label.text = text
    }

}

class MyView: UIView, UIScrollViewDelegate {
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

    let contentView: UIView = {
//        let view = ContentView(frame: .zero)
        let view = UIView()
//        view.configure(text: "New York")
        view.backgroundColor = .red
        return view
    }()

    let actionView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    let actionWidth: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)

        scrollView.delegate = self
        scrollView.addSubview(contentView)
        scrollView.addSubview(actionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentSize = CGSize(width: bounds.width + actionWidth, height: bounds.height)
        scrollView.frame = bounds
        contentView.frame = bounds

        var actionFrame = bounds
        actionFrame.origin.x = contentView.frame.maxX
        actionFrame.size.width = actionWidth
        actionView.frame = actionFrame
    }

    // MARK: UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = actionView.bounds.width
        let actionPercentVisible = scrollView.contentOffset.x / width

        let alpha: CGFloat
        if actionPercentVisible > 0 {
            alpha = 1 - min(actionPercentVisible, 1) * 0.5
        } else {
            alpha = 1
        }
        contentView.alpha = alpha
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let width = actionView.bounds.width
        let actionPercentVisible = scrollView.contentOffset.x / width

        let x: CGFloat
        if actionPercentVisible > 0.5 {
            x = width
        } else {
            x = 0
        }
        targetContentOffset.pointee.x = x
    }
}

let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
container.backgroundColor = .black
PlaygroundPage.current.liveView = container

//let myView = MyView(frame: container.bounds.insetBy(dx: 20, dy: 40))
//container.addSubview(myView)

let contentView = ContentView(frame: container.bounds.insetBy(dx: 20, dy: 40))
container.addSubview(contentView)

var mapRegion = MKCoordinateRegion()

// center the map on our office
mapRegion.center = CLLocationCoordinate2DMake(42.396701, -71.120087)
mapRegion.span.latitudeDelta = 0.05
mapRegion.span.longitudeDelta = 0.05
contentView.mapView.setRegion(mapRegion, animated: true)
