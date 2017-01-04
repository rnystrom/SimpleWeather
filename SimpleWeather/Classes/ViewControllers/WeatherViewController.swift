//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/13/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import CoreLocation

class WeatherViewController: UIViewController, IGListAdapterDataSource, LocationTrackerDelegate {

    @IBOutlet weak var collectionView: IGListCollectionView!
    @IBOutlet weak var alertsButton: UIButton!

    lazy var pulser: ViewPulser = {
        return ViewPulser(view: self.alertsButton)
    }()

    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var tracker: LocationTracker?
    var task: URLSessionDataTask?

    var location: SavedLocation?
    var forecast: Forecast?

    deinit {
        task?.cancel()
    }

    // MARK: Private API

    func updateAlertButton() {
        if let alerts = forecast?.alerts, alerts.count > 0 {
            pulser.enable()
        } else {
            pulser.disable()
        }
    }

    func fetch() {
        guard let location = location else { return }

        if location.userLocation == true {
            fetchCurrentLocation()
        } else {
            fetch(lat: location.latitude, lon: location.longitude)
        }
    }

    func fetchCurrentLocation() {
        tracker = LocationTracker()
        tracker?.delegate = self
        tracker?.getLocation()
    }

    func fetch(lat: Double, lon: Double) {
        guard let url = WundergroundForecastURL(apiKey: API_KEY, lat: lat, lon: lon) else { return }
        let request = URLSessionDataTaskResponse(serializeJSON: true) { (json: Any) -> Forecast? in
            guard let json = json as? [String: Any] else { return nil }
            return Forecast.fromJSON(json: json)
        }
        task = URLSession.shared.fetch(url: url, request: request) { [weak self] (result: URLSessionResult) in
            switch result {
            case let .success(forecast):
                self?.forecast = forecast
                self?.title = forecast.location?.city
                self?.adapter.performUpdates(animated: true)
                self?.updateAlertButton()
            case .failure(_): break
            }
        }
    }

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        fetch()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(WeatherViewController.applicationWillEnterForeground(notification:)),
            name: .UIApplicationWillEnterForeground,
            object: nil
        )

        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateAlertButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pulser.disable()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let alertsVC = segue.destination as? AlertsViewController {
            alertsVC.alerts = forecast?.alerts
        }
    }

    // MARK: IGListAdapterDataSource

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        var objects = [IGListDiffable]()
        guard let forecast = forecast else { return objects }

        if let location = forecast.location {
            let radar = RadarSection(
                center: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon),
                width: 1
            )
            objects.append(radar)
        }

        let sortedDaily = forecast.daily?.sorted(by: { $0.date > $1.date })

        if let conditions = ConditionsSection.from(observation: forecast.observation, today: sortedDaily?.first, astronomy: forecast.astronomy) {
            objects.append(conditions)
        }

        if let hourly = EmbeddedSection.from(forecast: forecast) {
            objects.append(hourly)
        }

        if let dailySection = DailyForecastSection.from(forecast: forecast) {
            objects.append(dailySection)
        }

        return objects
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is ConditionsSection {
            return ConditionsSectionController()
        } else if object is DailyForecastSection {
            return DailyForecastSectionController()
        } else if object is EmbeddedSection {
            return EmbeddedAdapterSectionController(height: 96, dataSource: ForecastHourlyDataSource())
        } else if object is RadarSection {
            return RadarSectionController()
        }
        return IGListSectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }

    // MARK: Notifications

    func applicationWillEnterForeground(notification: Notification) {
        let expiration: TimeInterval = 60 * 20 // 20 minutes
        if let observationDate = forecast?.observation?.date, -1 * observationDate.timeIntervalSinceNow >= expiration {
            fetchCurrentLocation()
        }
    }

    // MARK: LocationTrackerDelegate

    func didFinish(tracker: LocationTracker, result: LocationResult) {
        switch result {
        case let .success(location):
            fetch(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        default:
            print("Error tracking location")
        }
    }

}
