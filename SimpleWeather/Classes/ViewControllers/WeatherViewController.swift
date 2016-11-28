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

class WeatherViewController: UIViewController, IGListAdapterDataSource {

    @IBOutlet weak var collectionView: IGListCollectionView!
    @IBOutlet weak var alertsButton: UIButton!

    lazy var pulser: ViewPulser = {
        return ViewPulser(view: self.alertsButton)
    }()

    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var session: APISession? {
        didSet {
            session?.getForecastForCurrentLocation(completion: { [weak self] (forecast: Forecast?, error: Error?) in
                self?.forecast = forecast
                self?.title = forecast?.location?.city
                self?.adapter.performUpdates(animated: true)
                self?.updateAlertButton()
            })
        }
    }

    var forecast: Forecast?

    // MARK: Private API

    func updateAlertButton() {
        if let alerts = forecast?.alerts, alerts.count > 0 {
            pulser.enable()
        } else {
            pulser.disable()
        }
    }

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
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

        if let observation = forecast.observation,
            let today = sortedDaily?.first,
            let sunrise = forecast.astronomy?.sunrise,
            let sunset = forecast.astronomy?.sunset {
            let timeOfDay = Date().timeOfDay(sunrise: sunrise, sunset: sunset)
            let viewModel = ConditionsCellViewModel(
                temperature: Int(observation.temp),
                high: today.high,
                low: today.low,
                conditionImageName: observation.condition.icon(night: timeOfDay == .night),
                feelsLike: observation.feelslike
            )
            objects.append(viewModel)
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
        if object is ConditionsCellViewModel {
            return ConditionsSectionController()
        } else if object is DailyForecastSection {
            return DailyForecastSectionController()
        } else if object is EmbeddedSection {
            return EmbeddedAdapterSectionController(height: 80, dataSource: ForecastHourlyDataSource())
        } else if let session = session, object is RadarSection {
            return RadarSectionController(session: session)
        }
        return IGListSectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }

}
