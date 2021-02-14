//
//  Feed.swift
//  TransitFeeds
//
//  Created by Alex Lucas on 2/13/21.
//

import Foundation
import CoreLocation

struct FeedWrapper: Codable {
    var feeds: [Feed]
}

struct Feed: Codable {
    var id: Int
    var code: String
    var timezone: String
    var bounds: Bound
    var name: String
    var location: String
    var countryCode: String
}

struct Bound: Codable {
    var minLat: CLLocationDegrees
    var maxLat: CLLocationDegrees
    var minLon: CLLocationDegrees
    var maxLon: CLLocationDegrees

    var midpoint: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
    }
}
