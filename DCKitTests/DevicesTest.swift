//
//  DevicesTest.swift
//  DCKit
//
//  Created by Vladimir Kolbas on 9/1/15.
//  Copyright (c) 2015 Vladimir Kolbas. All rights reserved.
//

import UIKit
import XCTest
import DCKit

class DevicesTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPhone() {
        
        let device = UIDevice.currentDevice().name

        switch device {
        case let value where value.hasPrefix("iPhone"):
            XCTAssert(UIDevice.currentDevice().dc_deviceIsIphone, "Pass")
        case let value where value.hasPrefix("iPad"):
            XCTAssert(UIDevice.currentDevice().dc_deviceIsIpad, "Pass")
        case let value where value.hasPrefix("iPod"):
            XCTAssert(UIDevice.currentDevice().dc_deviceIsIpod, "Pass")
        default:
            XCTAssert(false, "Failed to determine device")
        }
    }

}
