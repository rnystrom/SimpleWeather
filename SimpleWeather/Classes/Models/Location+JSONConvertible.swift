//
//  Location+JSONConvertible.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/15/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Location: JSONConvertible {

    static func fromJSON(json: [String : Any]) -> Location? {
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
        return Location(
            type: type,
            country: country,
            country_iso3166: country_iso3166,
            country_name: country_name,
            state: state,
            city: city,
            tz_short: tz_short,
            tz_long: tz_long,
            lat: lat,
            lon: lon,
            zip: zip,
            magic: magic,
            wmo: wmo,
            l: l,
            requesturl: requesturl,
            wuiurl: wuiurl
        )
    }

}
