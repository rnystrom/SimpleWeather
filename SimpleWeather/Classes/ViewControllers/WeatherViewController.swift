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

class WeatherViewController: UIViewController, IGListAdapterDataSource, LocationTrackerDelegate, ErrorSectionControllerDelegate {

    @IBOutlet weak var collectionView: IGListCollectionView!
    @IBOutlet weak var alertsButton: UIButton!

    let stateMachine = WeatherStateMachine()

    lazy var pulser: ViewPulser = {
        return ViewPulser(view: self.alertsButton)
    }()

    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var tracker: LocationTracker?
    var task: URLSessionDataTask?
    var forecast: Forecast?
    var location: SavedLocation? { didSet { updateTitle() } }

    deinit {
        task?.cancel()
    }

    // MARK: Private API

    func updateAlertButton() {
        if WeatherNavigationShouldDisplayAlerts(forecast: forecast) {
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
        guard let url = WundergroundForecastURL(apiKey: API_KEY, lat: lat, lon: lon),
            task?.originalRequest?.url != url || task?.state != .running
            else { return }

        let request = URLSessionDataTaskResponse(serializeJSON: true) { (json: Any) -> Forecast? in
            guard let json = json as? [String: Any] else { return nil }
            return Forecast.fromJSON(json: json)
        }

        task?.cancel()
        task = URLSession.shared.fetch(url: url, request: request) { [weak self] (result: URLSessionResult) in
            switch result {
            case let .success(forecast):
                self?.forecast = forecast
                self?.updateTitle()
                self?.stateMachine.state = .forecast(forecast)
            case let .failure(error):
                self?.stateMachine.state = .fetchError(error)
            }

            self?.adapter.performUpdates(animated: true)
            self?.updateAlertButton()
        }
    }

    func updateTitle() {
        guard let location = location else { return }
        title = WeatherNavigationTitle(location: location, forecast: forecast)
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
        return stateMachine.objects
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
        } else if object is ErrorViewModel {
            let errorSectionController = ErrorSectionController()
            errorSectionController.delegate = self
            return errorSectionController
        }
        return IGListSectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return LoadingView()
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
        case let .failure(error):
            stateMachine.state = .locationError(error)
            adapter.performUpdates(animated: true)
        }
    }

    // MARK: ErrorSectionControllerDelegate

    func errorSectionControllerDidTapRetry(errorSectionController: ErrorSectionController) {
        stateMachine.state = .empty
        adapter.performUpdates(animated: true)
        fetch()
    }

}
