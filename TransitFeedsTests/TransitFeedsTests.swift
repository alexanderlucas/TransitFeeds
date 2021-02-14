//
//  TransitFeedsTests.swift
//  TransitFeedsTests
//
//  Created by Alex Lucas on 2/13/21.
//

import XCTest
@testable import TransitFeeds

class TransitFeedsTests: XCTestCase {

    func testLoadFeed() {
        let promise = expectation(description: "feed loaded successfully")
        
        let webService = WebService()

        webService.loadFeeds { (result) in
            switch result {
            case .success(_):
                promise.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error)")

            }
        }
        
        wait(for: [promise], timeout: 5)

    }

    func testMidpointFromZeroToOne() {
        let bound = Bound(minLat: 0, maxLat: 1, minLon: 0, maxLon: 1)

        XCTAssertEqual(bound.midpoint.latitude, 0.5, "Midpoint of [0, 1] is incorrect")
        XCTAssertEqual(bound.midpoint.longitude, 0.5, "Midpoint of [0, 1] is incorrect")

    }

    func testMidpoint_latitudeFromZeroToOne_longitudeFromNegativeOneToOne() {
        let bound = Bound(minLat: 0, maxLat: 1, minLon: -1, maxLon: 1)

        XCTAssertEqual(bound.midpoint.latitude, 0.5, "Midpoint of [0, 1] is incorrect")
        XCTAssertEqual(bound.midpoint.longitude, 0, "Midpoint of [-1, 1] is incorrect")
    }

    func testMidpoint_latitudeOne_longitudeFromZeroToOne() {
        let bound = Bound(minLat: 1, maxLat: 1, minLon: 0, maxLon: 1)

        XCTAssertEqual(bound.midpoint.latitude, 1, "Midpoint of [1, 1] is incorrect")
        XCTAssertEqual(bound.midpoint.longitude, 0.5, "Midpoint of [0, 1] is incorrect")

    }

}
