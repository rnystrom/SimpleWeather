//
//  Location.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/14/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Location {

    let type: String
    let country: String
    let country_iso3166: String
    let country_name: String
    let state: String
    let city: String
    let tz_short: String
    let tz_long: String
    let lat: Double
    let lon: Double
    let zip: Int
    let magic: String
    let wmo: String
    let l: String
    let requesturl: String
    let wuiurl: String

    init?(json: [String: Any]) {
        guard let type = json["type"] as? String,
            let country = json["country"] as? String,
            let country_iso3166 = json["country_iso3166"] as? String,
            let country_name = json["country_name"] as? String,
            let state = json["state"] as? String,
            let city = json["city"] as? String,
            let tz_short = json["tz_short"] as? String,
            let tz_long = json["tz_long"] as? String,
            let lat = (json["lat"] as? NSString)?.doubleValue,
            let lon = (json["lon"] as? NSString)?.doubleValue,
            let zip = (json["zip"] as? NSString)?.integerValue,
            let magic = json["magic"] as? String,
            let wmo = json["wmo"] as? String,
            let l = json["l"] as? String,
            let requesturl = json["requesturl"] as? String,
            let wuiurl = json["wuiurl"] as? String
            else { return nil }
        self.type = type
        self.country = country
        self.country_iso3166 = country_iso3166
        self.country_name = country_name
        self.state = state
        self.city = city
        self.tz_short = tz_short
        self.tz_long = tz_long
        self.lat = lat
        self.lon = lon
        self.zip = zip
        self.magic = magic
        self.wmo = wmo
        self.l = l
        self.requesturl = requesturl
        self.wuiurl = wuiurl
    }

}
