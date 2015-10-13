//
//  EmailValidationTests.swift
//  DCKit
//
//  Created by Kristijan Delivuk on 10/13/15.
//  Copyright © 2015 Vladimir Kolbas. All rights reserved.
//

import XCTest

class EmailValidationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmailValidation() {
        
        let email = "ime.prezime@iz.hr" as NSString
        let email2 = "test.test@test.com" as NSString
        let email3 = "test11111.com" as NSString
        let email4 = "ime.prezime@decode.agency" as NSString
        let email5 = "@test.com" as NSString
        let email6 = "auth@verifier.port25.com" as NSString
        let email7 = "test@agency.agency" as NSString
        let email8 = "m@m.io" as NSString
        
        
        XCTAssertTrue(email.dc_isValidEmail(), "Email is not valid")
        XCTAssertTrue(email2.dc_isValidEmail(), "Email is not valid")
        XCTAssertFalse(email3.dc_isValidEmail(), "Email is valid")
        XCTAssertTrue(email4.dc_isValidEmail(), "Email is not valid")
        XCTAssertFalse(email5.dc_isValidEmail(), "Email is valid")
        XCTAssertTrue(email6.dc_isValidEmail(), "Email is valid")
        XCTAssertTrue(email7.dc_isValidEmail(), "Email is valid")
        XCTAssertTrue(email8.dc_isValidEmail(), "Email is valid")
        
    }
    
}
