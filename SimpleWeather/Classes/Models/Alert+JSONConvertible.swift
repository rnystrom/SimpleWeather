//
//  Alert+JSONConvertible.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/15/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Alert: JSONConvertible {

    static func fromJSON(json: [String : Any]) -> Alert? {
        guard let description = json["description"] as? String,
            let date_epoch = json["date_epoch"] as? String,
            let expires_epoch = json["expires_epoch"] as? String,
            let message = json["message"] as? String,
            let phenomena_code = json["phenomena"] as? String,
            let significance_code = json["significance"] as? String,
            let date_interval = TimeInterval(date_epoch),
            let expires_interval = TimeInterval(expires_epoch)
            else { return nil }

        // http://www.nws.noaa.gov/os/vtec/pdfs/VTEC_explanation6.pdf
        let significance: Significance
        switch significance_code {
        case "W": significance = .warning
        case "A": significance = .watch
        case "Y": significance = .advisory
        case "S": significance = .statement
        case "F": significance = .forecast
        case "O": significance = .outlook
        case "N": significance = .synopsys
        default: significance = .unknown
        }

        // http://www.nws.noaa.gov/os/vtec/pdfs/VTEC_explanation6.pdf
        let phenomena: String
        switch phenomena_code {
        case "AF": phenomena = "Ashfall"
        case "AS": phenomena = "Air Stagnation"
        case "BS": phenomena = "Blowing Snow"
        case "BW": phenomena = "Brisk Wind"
        case "BZ": phenomena = "Blizzard"
        case "CF": phenomena = "Coastal Flood"
        case "DS": phenomena = "Dust Storm"
        case "DU": phenomena = "Blowing Dust"
        case "EC": phenomena = "Extreme Cold"
        case "EH": phenomena = "Excessive Heat"
        case "EW": phenomena = "Extreme Wind"
        case "FA": phenomena = "Areal Flood"
        case "FF": phenomena = "Flash Flood"
        case "FG": phenomena = "Dense Fog"
        case "FL": phenomena = "Flood"
        case "FR": phenomena = "Frost"
        case "FW": phenomena = "Fire Weather"
        case "FZ": phenomena = "Freeze"
        case "GL": phenomena = "Gale"
        case "HF": phenomena = "Hurricane Force Wind"
        case "HI": phenomena = "Inland Hurricane"
        case "HS": phenomena = "Heavy Snow"
        case "HT": phenomena = "Heat"
        case "HU": phenomena = "Hurricane"
        case "HW": phenomena = "High Wind"
        case "HY": phenomena = "Hydrologic"
        case "HZ": phenomena = "Hard Freeze"
        case "IP": phenomena = "Sleet"
        case "IS": phenomena = "Ice Storm"
        case "LB": phenomena = "Lake Effect Snow and Blowing Snow"
        case "LE": phenomena = "Lake Effect Snow"
        case "LO": phenomena = "Low Water"
        case "LS": phenomena = "Lakeshore Flood"
        case "LW": phenomena = "Lake Wind"
        case "MA": phenomena = "Marine"
        case "RB": phenomena = "Small Craft for Rough Bar"
        case "SB": phenomena = "Snow and Blowing Snow"
        case "SC": phenomena = "Small Craft"
        case "SE": phenomena = "Hazardous Seas"
        case "SI": phenomena = "Small Craft for Winds"
        case "SM": phenomena = "Dense Smoke"
        case "SN": phenomena = "Snow"
        case "SR": phenomena = "Storm"
        case "SU": phenomena = "High Surf"
        case "SV": phenomena = "Severe Thunderstorm"
        case "SW": phenomena = "Small Craft for Hazardous Seas"
        case "TI": phenomena = "Inland Tropical Storm"
        case "TO": phenomena = "Tornado"
        case "TR": phenomena = "Tropical Storm"
        case "TS": phenomena = "Tsunami"
        case "TY": phenomena = "Typhoon"
        case "UP": phenomena = "Ice Accretion"
        case "WC": phenomena = "Wind Chill"
        case "WI": phenomena = "Wind"
        case "WS": phenomena = "Winter Storm"
        case "WW": phenomena = "Winter Weather"
        case "ZF": phenomena = "Freezing Fog"
        case "ZR": phenomena = "Freezing Rain"
        default: phenomena = "Unknown"
        }

        return Alert(
            description: description,
            date: Date(timeIntervalSince1970: date_interval),
            expires: Date(timeIntervalSince1970: expires_interval),
            message: message,
            phenomena: phenomena,
            significance: significance
        )
    }

}
