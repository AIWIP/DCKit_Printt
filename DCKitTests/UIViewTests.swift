//
//  UIViewTests.swift
//  DCKit
//
//  Created by Vladimir Kolbas on 9/8/15.
//  Copyright (c) 2015 Vladimir Kolbas. All rights reserved.
//

import UIKit
import XCTest

class UIViewTests: XCTestCase {

    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func initialView() -> UIView {
        return UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    }
    
    func testCenterOriginal() {
        let view = initialView()
        let center = view.center
        XCTAssertEqual(center, CGPoint(x: 150, y: 150), "Center should be 50,50")
        
        view.center = CGPoint(x: 100, y: 100)
        XCTAssertEqual(view.center, CGPoint(x: 100, y:100))
    }

    func testCenterMove() {
        var view = initialView()
        view.dc_centerX = 100
        view.dc_centerY = 100
        
        XCTAssertEqual(view.center, CGPoint(x: 100, y: 100), "Center should be (100, 100)")
        XCTAssertEqual(view.center, CGPoint(x: view.dc_centerX, y: view.dc_centerY))
        
    }
    
    func testWidth() {
        let view = initialView()
        view.dc_width = 200
        XCTAssertEqual(view.bounds.size.width, 200, "Width should be 150")
        XCTAssertEqual(view.dc_width, view.bounds.size.width, "Width should be 150")
        
    }
    
    func testHeight() {
        let view = initialView()
        view.dc_height = 200
        XCTAssertEqual(view.bounds.size.height, 200, "Width should be 150")
        XCTAssertEqual(view.bounds.size.height, view.dc_height)
    }
    
    func testX() {
        let view = initialView()
        view.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        let x : CGFloat = 50
        XCTAssertEqual(view.dc_x, x, "x should be \(x)")
        view.dc_x = 150
        XCTAssertEqual(view.frame.origin.x, 150)
        
    }

    func testY() {
        let view = initialView()
        view.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        let y : CGFloat = 50
        XCTAssertEqual(view.dc_y, y, "y should be \(y)")
        view.dc_y = 150
        XCTAssertEqual(view.frame.origin.y, 150)
    }
    
    func testXRight() {
        let view = initialView()
        view.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        XCTAssertEqual(view.dc_xRight, 250, "x right should be 250")
        
        view.dc_xRight = 200
        XCTAssertEqual(view.dc_xRight, 200)
        XCTAssertEqual(view.dc_width, 200 - view.frame.origin.x)
    }
    
    func testYBottom() {
        let view = initialView()
        view.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        XCTAssertEqual(view.dc_yBottom, 250)
        
        view.dc_yBottom = 200
        XCTAssertEqual(view.dc_yBottom, 200)
        XCTAssertEqual(view.dc_height, 200 - view.frame.origin.y)
    }

}
