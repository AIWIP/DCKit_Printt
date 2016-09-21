//
//  DCKitColorTests.swift
//  DCKit
//
//  Created by Vladimir Kolbas on 9/3/15.
//  Copyright (c) 2015 Vladimir Kolbas. All rights reserved.
//

import UIKit
import XCTest

class DCKitColorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testColor() {
        
        let redFromHex = UIColor(dc_hexValue: 0xff0000)
        
        XCTAssert(redFromHex == UIColor.red, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }

}
