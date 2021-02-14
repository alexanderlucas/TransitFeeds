//
//  FeedAnnotation.swift
//  TransitFeeds
//
//  Created by Alex Lucas on 2/14/21.
//

import MapKit

class FeedAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D

    var title: String?
    var subtitle: String?

    var feed: Feed

    init(coordinate: CLLocationCoordinate2D, feed: Feed) {
        self.coordinate = coordinate
        self.feed = feed
        self.title = feed.name
        self.subtitle = feed.location
    }
    
}
