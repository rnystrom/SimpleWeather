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

    var forecast: Forecast? {
        didSet {
            title = forecast?.location?.city
        }
    }

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

        if let conditions = forecast.conditions,
            let today = sortedDaily?.first {
            let viewModel = ConditionsCellViewModel(temperature: Int(conditions.temp),
                                                    high: today.high,
                                                    low: today.low,
                                                    conditionsEmoji: conditions.icon.emoji)
            objects.append(viewModel)
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
        }
        return IGListSectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }

}
