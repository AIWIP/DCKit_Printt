//
//  ArrayTests.swift
//  DCKit
//
//  Created by Kristijan Delivuk on 10/13/15.
//  Copyright © 2015 Vladimir Kolbas. All rights reserved.
//

import XCTest
@testable import DCKit

class ArrayTests: XCTestCase {

    var array = ["One" , "Two" , "Three" , "Four" , "Five"]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIfArrayConstainsObject() {
        
        XCTAssertTrue(array.dc_contains("One"), "Array 'dc_contains' function isn't working properly.")
    }
    
    func testRemovingObjectFromArray() {
        XCTAssertTrue(array.dc_removeObject("One"), "Array 'dc_removeObject' function isn't working properly.")

    }

    func testFindingObjectFromArray() {

        let index = array.dc_find { (let element) -> Bool in
            return element == "Three"
        }
        
        XCTAssertTrue(index == 2, "Array 'dc_find' function isn't working properly.")
    }
}