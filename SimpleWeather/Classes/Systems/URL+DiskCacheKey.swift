//
//  URL+DiskCacheKey.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension URL {

    var diskCacheKey: String {
        let str = absoluteString
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var r = [UInt8](repeating: 0, count: length)

        if let d = str.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &r)
            }
        }

        let ext = pathExtension == "" ? "" : "." + pathExtension
        return String(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%",
                      r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14],
                      r[15]) + ext
    }
    
}
