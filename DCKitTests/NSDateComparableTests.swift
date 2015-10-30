//
//  NSDateComparableTests.swift
//  DCKit
//
//  Created by Vladimir Kolbas on 10/30/15.
//  Copyright © 2015 Vladimir Kolbas. All rights reserved.
//

import XCTest
@testable import DCKit

class NSDateComparableTests: XCTestCase {

    let now = NSDate()
    let later = NSDate(timeIntervalSinceNow: 10)
    let before = NSDate(timeIntervalSinceNow: -10)
    
    override func setUp() {
        
    }
    
    func testGreater() {
        XCTAssertTrue(later > now, "Later should be later than now")
        XCTAssertTrue(now > before, "Now should be later than before")
        XCTAssertFalse(later < now, "Later should be later than now")
        XCTAssertFalse(now < before, "Now should be later than before")
    }
    
    func testGreaterOrEqual() {
        XCTAssertTrue(later >= now, "Later should be later than now")
        XCTAssertTrue(now >= before, "Now should be later than before")
        XCTAssertTrue(now >= now, "Now should be equal to now")
        XCTAssertTrue(now <= now, "Now should be equal to now")
        XCTAssertFalse(now <= before, "Now is later tha before")
    }
    
    func testEqual() {
        XCTAssertTrue(now == now, "Now should be equal to now")
        XCTAssertFalse(now == later, "Now is not later")
    }
    
    func testBeforeOrEqual() {
        XCTAssertTrue(before <= now, "Before should be before now")
        XCTAssertTrue(now <= later, "Now should be before later")
        XCTAssertFalse(now >= later, "Now is not after later")
    }

    func testBefore() {
        XCTAssertTrue(before <= now, "Before should be before now")
        XCTAssertTrue(now <= later, "Now should be before later")
        XCTAssertFalse(now < before, "Now is after before")
    }
}