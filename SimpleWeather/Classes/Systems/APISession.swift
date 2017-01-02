//
//  ForecastNetworking.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/17/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import CoreLocation

class APISession {

    typealias APISessionForecastCompletion = (Forecast?, Error?) -> Void
    typealias APISessionRadarCompletion = (UIImage?, Error?) -> Void

    let session: URLSession
    let key: String

    var locationRequester: LocationRequester?
    var task: URLSessionDataTask?

    init(key: String, session: URLSession = URLSession.shared) {
        self.key = key
        self.session = session
    }

    // MARK: Public API

    public func getForecastForCurrentLocation(completion: @escaping APISessionForecastCompletion) {
        locationRequester = LocationRequester()
        locationRequester?.getLocation(completion: { [weak self] (location: CLLocation?, error: Error?) in
            if let coordinate = location?.coordinate {
                self?.getForecast(lat: coordinate.latitude, lon: coordinate.longitude, completion: completion)
            } else {
                completion(nil, error)
            }
        })
    }

    public func getForecast(lat: Double, lon: Double, completion: @escaping APISessionForecastCompletion) {
        guard let url = forecastURL(lat: lat, lon: lon), task?.originalRequest?.url != url else { return }

        let mainCompletion: APISessionForecastCompletion = { [weak self] (f: Forecast?, e: Error?) in
            DispatchQueue.main.async {
                self?.task = nil
                completion(f, e)
            }
        }

        print("Fetching " + url.absoluteString)
        task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let castedJSON = json as? [String: Any] {
                mainCompletion(Forecast.fromJSON(json: castedJSON), nil)
            } else {
                mainCompletion(nil, error)
            }
        })
        task?.resume()
    }

    public func getRadar(minLat: Double, minLon: Double, maxLat: Double, maxLon: Double,
                         width: Double, height: Double, completion: @escaping APISessionRadarCompletion) {
        guard let url = radarURL(minLat: minLat, minLon: minLon, maxLat: maxLat, maxLon: maxLon, width: width, height: height)
            else { return }

        print("Fetching radar image: \(url)")

        let mainCompletion: APISessionRadarCompletion = { (i: UIImage?, e: Error?) in
            DispatchQueue.main.async {
                completion(i, e)
            }
        }

        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data,
                let image = UIImage(data: data) {
                mainCompletion(image, nil)
            } else {
                mainCompletion(nil, error)
            }
        })
        task.resume()
    }

    // MARK: Private API

    internal func forecastURL(lat: Double, lon: Double) -> URL? {
        let latlon = String(format: "%.2f,%.2f", lat, lon)
        let functions = ["forecast", "geolookup", "conditions", "forecast10day", "alerts", "hourly", "astronomy"]
        return URL(string: base(functions: functions, query: latlon))
    }

    internal func radarURL(minLat: Double, minLon: Double, maxLat: Double, maxLon: Double, width: Double, height: Double) -> URL? {
        let query = String(format: "maxlat=%f&maxlon=%f&minlat=%f&minlon=%f&width=%.0f&height=%.0f&rainsnow=1",
                            maxLat, maxLon, minLat, minLon, width, height)
        let urlString = base + "radar/image.png?" + query
        return URL(string: urlString)
    }

    private var base: String {
        return "http://api.wunderground.com/api/\(key)/"
    }

    private func base(functions: [String], query: String) -> String {
        return base + functions.joined(separator: "/") + "/q/" + query + ".json"
    }
    
}
