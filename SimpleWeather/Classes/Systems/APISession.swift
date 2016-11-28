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
    let limiter: RateLimiter

    var locationRequester: LocationRequester?
    var task: URLSessionDataTask?

    init(key: String, limiter: RateLimiter, session: URLSession = URLSession.shared) {
        self.key = key
        self.limiter = limiter
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

        if limiter.attempt() {
            print("Fetching " + url.absoluteString)
            task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []),
                    let castedJSON = json as? [String: Any] {
                    self.saveCachedResponse(url: url, data: data)
                    mainCompletion(Forecast.fromJSON(json: castedJSON), nil)
                } else {
                    mainCompletion(nil, error)
                }
            })
            task?.resume()
        } else {
            print("Rate limited, fetching last response from disk")
            DispatchQueue.global().async {
                if let json = self.fetchCachedResponse(url: url) {
                    mainCompletion(Forecast.fromJSON(json: json), nil)
                } else {
                    mainCompletion(nil, nil)
                }
            }
        }
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

    private func cacheURL(url: URL) -> URL? {
        let diskKey = url.diskCacheKey
        if let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first {
            return URL(fileURLWithPath: cachePath).appendingPathComponent(diskKey)
        } else {
            return nil
        }
    }

    private func fetchCachedResponse(url: URL) -> [String: Any]? {
        if let fileURL = cacheURL(url: url),
            let data = try? Data(contentsOf: fileURL),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return json
        } else {
            return nil
        }
    }

    private func saveCachedResponse(url: URL, data: Data) {
        if let fileURL = cacheURL(url: url) {
            do {
                try data.write(to: fileURL, options: [.atomic])
            } catch let err {
                print(err)
            }
        }
    }

    
    
}
