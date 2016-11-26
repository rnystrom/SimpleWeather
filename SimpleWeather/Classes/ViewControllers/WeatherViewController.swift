//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/13/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class WeatherViewController: UIViewController, IGListAdapterDataSource {

    @IBOutlet weak var collectionView: IGListCollectionView!
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var session: APISession? {
        didSet {
            session?.getForecastForCurrentLocation(completion: { (forecast: Forecast?, error: Error?) in
                self.forecast = forecast
                self.title = forecast?.location?.city
                self.adapter.performUpdates(animated: true)
            })
        }
    }

    var forecast: Forecast?

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    //MARK: IGListAdapterDataSource

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        var objects = [IGListDiffable]()
        guard let forecast = forecast else { return objects }

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
                conditionsEmoji: observation.condition.emoji(night: timeOfDay == .night)
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
        }
        return IGListSectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }

}
