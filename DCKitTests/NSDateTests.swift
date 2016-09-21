//
//  NSDateTests.swift
//  DCKit
//
//  Created by Kristijan Delivuk on 10/12/15.
//  Copyright © 2015 Vladimir Kolbas. All rights reserved.
//

import XCTest
@testable import DCKit

class NSDateTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // - MARK: Tests

    func testIf24HourModeIsEnabled() {
        
        let dateIsIn12HourMode = NSDate.dc_is24HourModeEnabled()
        
        let locale24 = Locale.current
        
        let dateFormat24 = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale24)!
        
        if dateFormat24.range(of: "a") != nil {
            XCTAssertEqual(dateIsIn12HourMode, false, "24 hours mode.")
        }

    }

    func testIfDatesAreSameDay() {
        let today = NSDate()
        let tomorrow = NSDate().addingTimeInterval(60*60*24)
        
        XCTAssertFalse(today.dc_isSameDay(tomorrow), "NSDate 'dc_isSameDay' function isn't working properly.")
        XCTAssertTrue(today.dc_isSameDay(NSDate()), "NSDate 'dc_isSameDay' function isn't working properly.")
        
    }

    func testDateNumberOfUnits() {
        
        let calendar = Calendar.current
        let calendarFlags:NSCalendar.Unit = [.year, .month, .day]
        
        let dateComponents = (calendar as NSCalendar).components(calendarFlags, from: Date())
        
        XCTAssertEqual(NSDate().dc_numberOfUnits([.year, .month, .day]) , dateComponents as NSDateComponents, "NSDate 'dc_numberOfUnits' function isn't working properly.")
        
    }

    func testIfDateIsEqualToday() {
        let today = NSDate()
        
        XCTAssertTrue(today.dc_isToday(), "NSDate 'dc_isToday' function isn't working properly.")
    }

    func testIfTommorowWillBeEqualToDate() {
        let date = NSDate().addingTimeInterval(60*60*24)
        
        XCTAssertTrue(date.dc_isTomorrow(), "NSDate 'dc_isTomorrow' function isn't working properly")
        XCTAssertFalse(NSDate().dc_isTomorrow(), "NSDate 'dc_isTomorrow' function isn't working properly")
    }

    func testAddingDays() {
        let date = NSDate()

        XCTAssertEqual(date.dc_dateByAddingDays(5), date.addingTimeInterval(60*60*24*5), "NSDate 'dc_dateByAddingDays' function isn't working properly")
        XCTAssertNotEqual(date.dc_dateByAddingDays(1), date, "NSDate 'dc_dateByAddingDays' function isn't working properly")
    }

    func testMonth() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.month, from: Date())
        
        XCTAssertEqual(components.month, NSDate().dc_month(), "NSDate 'dc_month' function isn't working properly")
    }

    func testHour() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.hour, from: Date())
        
        XCTAssertEqual(components.hour, NSDate().dc_hour(), "NSDate 'dc_hour' function isn't working properly")
    }
    
    func testDay() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: Date())
        
        XCTAssertEqual(components.day, NSDate().dc_day(), "NSDate 'dc_day' function isn't working properly")
    }

    func testMinute() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.minute, from: Date())
        
        XCTAssertEqual(components.minute, NSDate().dc_minute(), "NSDate 'dc_minute' function isn't working properly")
    }

    func testSecond() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.second, from: Date())
        
        XCTAssertEqual(components.second, NSDate().dc_second(), "NSDate 'dc_second' function isn't working properly")
    }

    func testDateWithComponents() {
        let calendar = Calendar.current
        
        var components1 = DateComponents()
        components1.year = 1987
        components1.month = 3
        components1.day = 17
        let newDate1: NSDate? = calendar.date(from: components1) as NSDate?
                
        components1.hour = 14
        components1.minute = 20
        components1.second = 0
    
        let newDate3: NSDate? = calendar.date(from: components1) as NSDate?

        let dateWithComponents = NSDate().dc_dateWithComponents(components1.year, month: components1.month, day: components1.day, hour:0, minute:0, second:0)
        let dateWithAllComponents = NSDate().dc_dateWithComponents(components1.year, month: components1.month, day: components1.day, hour: components1.hour, minute: components1.minute, second: components1.second)

    
        XCTAssertEqual(newDate1, dateWithComponents, "NSDate 'dc_dateWithComponents' function isn't working properly")
        XCTAssertEqual(newDate3, dateWithAllComponents, "NSDate 'dc_dateWithComponents' function isn't working properly")
    }

    func testWeekday() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.weekday, from: Date())
        
        XCTAssertEqual(components.weekday, NSDate().dc_weekday(), "NSDate 'dc_weekday' function isn't working properly")
    }

    func testWeekdayOrdinal() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.weekdayOrdinal, from: Date())
        
        XCTAssertEqual(components.weekdayOrdinal, NSDate().dc_weekdayOrdinal(), "NSDate 'dc_weekdayOrdinal' function isn't working properly")
    }

    func testWeekOfMonth() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.weekOfMonth, from: Date())
        
        XCTAssertEqual(components.weekOfMonth, NSDate().dc_weekOfMonth(), "NSDate 'dc_weekOfMonth' function isn't working properly")
    }

    func testWeekOfYear() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.weekOfYear, from: Date())
        
        XCTAssertEqual(components.weekOfYear, NSDate().dc_weekOfYear(), "NSDate 'dc_weekOfYear' function isn't working properly")
    }
    
    func testDayEra() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.era, from: Date())
        
        XCTAssertEqual(components.era, NSDate().dc_era(),"NSDate 'dc_era' function isn't working properly")
    }
    
    func testYear() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.year, from: Date())
        
        XCTAssertEqual(components.year, NSDate().dc_year(), "NSDate 'dc_year' function isn't working properly")
    }
    
    func testAddingMonths() {

        let calendar = Calendar.current
        
        var components = DateComponents()
        components.month = 10
        let date1 = (Calendar.current as NSCalendar).date(byAdding: components, to: Date(), options: NSCalendar.Options())
        let date2 = NSDate().dc_dateByAddingMonths(10)
        
        let components1 = (calendar as NSCalendar).components(.month, from: date1!)
        let components2 = (calendar as NSCalendar).components(.month, from: date2 as Date)
        
        XCTAssertEqual(components1, components2, "NSDate 'dc_dateByAddingMonths' function isn't working properly")
    }
    
    func testDaysInMonth() {
        let date = NSDate()
        let cal = Calendar.current
        
        let days = (cal as NSCalendar).range(of: .day, in: .month, for: date as Date).length
        
        XCTAssertEqual(days, date.dc_daysInMonth(), "NSDate 'dc_daysInMonth' function isn't working properly")
    }
    
    func testDaysInYear() {
        let date = NSDate()
        let cal = Calendar.current
        
        let days = (cal as NSCalendar).range(of: .day, in: .year, for: date as Date).length
        
        XCTAssertEqual(days, date.dc_daysInYear(), "NSDate 'dc_daysInYear' function isn't working properly")
    }
    
    func testDayOfYear() {
        let date = NSDate()
        let cal = Calendar.current
        
        let days = (cal as NSCalendar).range(of: .day, in: .year, for: date as Date).location
        
        XCTAssertEqual(days, date.dc_dayOfYear(), "NSDate 'dc_dayOfYear' function isn't working properly")
    }
    
    func testNumberOfDaysBetweenDates() {
        let date1 = NSDate()
        let date2 = NSDate().dc_dateByAddingDays(10)
        
        XCTAssertEqual(date1.dc_numberOfDaysBetween(date2), 10, "NSDate 'dc_dateByAddingDays' function isn't working properly")
    }
    
    func testFirstDayOfWeek() {
        var components = DateComponents()
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        components.year = 2015
        components.day = 20
        components.month = 10
    
        let testDateInWeek: NSDate = calendar.date(from: components)! as NSDate
        
        components.day = 18 + calendar.firstWeekday - 1
        
        let firstDayOfWeek: NSDate = calendar.date(from: components)! as NSDate
        
        XCTAssertTrue(firstDayOfWeek == testDateInWeek.dc_firstDayOfWeek(), "Wrong first day of the week")
    }

    func testLastDayOfWeek() {
        var components = DateComponents()
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        components.year = 2015
        components.day = 20
        components.month = 10
        
        let testDateInWeek: NSDate = calendar.date(from: components)! as NSDate
        
        components.day = 25 + calendar.firstWeekday - 1
        
        let lastDayOfWeek: NSDate = calendar.date(from: components)! as NSDate
        
        XCTAssertTrue(lastDayOfWeek == testDateInWeek.dc_lastDayOfWeek(), "Wrong last day of the week")
    }


    func testFirstDayOfMonth() {
        
        var components = DateComponents()
        
        components.year = 2015
        components.day = 30
        components.month = 10
        
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone.autoupdatingCurrent
        
        let testDateInMonth: NSDate = calendar.date(from: components)! as NSDate

        components.day = 1
        
        let firstDayOfMonth: NSDate = calendar.date(from: components)! as NSDate
        
        XCTAssertTrue(firstDayOfMonth == testDateInMonth.dc_firstDayOfMonth(), "First day in month is not the same")
    }

    func testLastDayOfMonth() {
        var components = DateComponents()
        
        components.year = 2015
        components.day = 30
        components.month = 10
        
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone.autoupdatingCurrent
        
        let testDateInMonth: NSDate = calendar.date(from: components)! as NSDate
        
        components.day = 31
        
        let lastDayInMonth: NSDate = calendar.date(from: components)! as NSDate
        
        XCTAssertTrue(lastDayInMonth == testDateInMonth.dc_lastDayOfMonth(), "Last date in month is not correct")
    }
    
    func testCompareSameWeek() {
        var components = DateComponents()
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        components.year = 2015
        components.day = 30
        components.month = 10
        
        let date1InWeek: NSDate = calendar.date(from: components)! as NSDate
        
        components.day = 29
        
        let date2InWeek: NSDate = calendar.date(from: components)! as NSDate
        
        components.year = 2011
        
        let dateNotInWeek: NSDate = calendar.date(from: components)! as NSDate
        XCTAssertTrue(date1InWeek.dc_isSameWeek(date2InWeek), "Should be in the same week")
        XCTAssertFalse(dateNotInWeek.dc_isSameWeek(date1InWeek), "Should not be in the same week")
    }
    
    func testSameWeekDay() {
        
        var components = DateComponents()
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        components.year = 2015
        components.day = 8
        components.month = 12
        
        let date1: NSDate = calendar.date(from: components)! as NSDate
        
        components.day = 9
        
        let date2: NSDate = calendar.date(from: components)! as NSDate
        
        XCTAssertFalse(date1.dc_isSameWeekday(date2), "Should be wednesday, not tuesday")
        
        components.day = 8 + 7
        
        let date3: NSDate = calendar.date(from: components)! as NSDate
        
        XCTAssertTrue(date1.dc_isSameWeekday(date3), "Should be tuesday")

    }
}
