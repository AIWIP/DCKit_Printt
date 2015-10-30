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
        
        let locale24 = NSLocale.currentLocale()
        
        let dateFormat24 = NSDateFormatter.dateFormatFromTemplate("j", options: 0, locale: locale24)!
        
        if dateFormat24.rangeOfString("a") != nil {
            XCTAssertEqual(dateIsIn12HourMode, false, "24 hours mode.")
        }

    }
    
    func testIfDatesAreSameDay() {
        let today = NSDate()
        let tomorrow = NSDate().dateByAddingTimeInterval(60*60*24)
        
        XCTAssertFalse(today.dc_isSameDay(tomorrow), "NSDate 'dc_isSameDay' function isn't working properly.")
        XCTAssertTrue(today.dc_isSameDay(NSDate()), "NSDate 'dc_isSameDay' function isn't working properly.")
        
    }
    
    func testDateNumberOfUnits() {
        
        let calendar = NSCalendar.currentCalendar()
        let calendarFlags:NSCalendarUnit = [.Year, .Month, .Day]
        
        let dateComponents = calendar.components(calendarFlags, fromDate: NSDate())
        
        XCTAssertEqual(NSDate().dc_numberOfUnits([.Year, .Month, .Day]) , dateComponents, "NSDate 'dc_numberOfUnits' function isn't working properly.")
        
    }
    
    func testIfDateIsEqualToday() {
        let today = NSDate()
        
        XCTAssertTrue(today.dc_isToday(), "NSDate 'dc_isToday' function isn't working properly.")
    }
    
    func testIfTommorowWillBeEqualToDate() {
        let date = NSDate().dateByAddingTimeInterval(60*60*24)
        
        XCTAssertTrue(date.dc_isTomorrow(), "NSDate 'dc_isTomorrow' function isn't working properly")
        XCTAssertFalse(NSDate().dc_isTomorrow(), "NSDate 'dc_isTomorrow' function isn't working properly")
    }

    func testAddingDays() {
        let date = NSDate()

        XCTAssertEqual(date.dc_dateByAddingDays(5), date.dateByAddingTimeInterval(60*60*24*5), "NSDate 'dc_dateByAddingDays' function isn't working properly")
        XCTAssertNotEqual(date.dc_dateByAddingDays(1), date, "NSDate 'dc_dateByAddingDays' function isn't working properly")
    }
    
    func testMonth() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: NSDate())
        
        XCTAssertEqual(components.month, NSDate().dc_month(), "NSDate 'dc_month' function isn't working properly")
    }
    
    func testHour() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: NSDate())
        
        XCTAssertEqual(components.hour, NSDate().dc_hour(), "NSDate 'dc_hour' function isn't working properly")
    }
    
    func testDay() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: NSDate())
        
        XCTAssertEqual(components.day, NSDate().dc_day(), "NSDate 'dc_day' function isn't working properly")
    }
    
    func testMinute() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: NSDate())
        
        XCTAssertEqual(components.minute, NSDate().dc_minute(), "NSDate 'dc_minute' function isn't working properly")
    }
    
    func testSecond() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Second, fromDate: NSDate())
        
        XCTAssertEqual(components.second, NSDate().dc_second(), "NSDate 'dc_second' function isn't working properly")
    }
    
    func testDateWithComponents() {
        let calendar = NSCalendar.currentCalendar()
        
        let components1 = NSDateComponents()
        components1.year = 1987
        components1.month = 3
        components1.day = 17
        let newDate1 = calendar.dateFromComponents(components1)
        
        let components2 = NSDateComponents()
        components2.hour = 14
        components2.minute = 20
        components2.second = 0
        let newDate2 = calendar.dateFromComponents(components2)
        
        components1.hour = 14
        components1.minute = 20
        components1.second = 0
    
        let newDate3 = calendar.dateFromComponents(components1)

        let dateWithComponents = NSDate().dc_dateWithComponents(components1.year, month: components1.month, day: components1.day)
        let dateWithHourComponents = NSDate().dc_dateWithComponents(hour: components2.hour, minute: components2.minute, second: components2.second)
        let dateWithAllComponents = NSDate().dc_dateWithComponents(components1.year, month: components1.month, day: components1.day, hour: components1.hour, minute: components1.minute, second: components1.second)

    
        XCTAssertEqual(newDate1, dateWithComponents, "NSDate 'dc_dateWithComponents' function isn't working properly")
        XCTAssertEqual(newDate2, dateWithHourComponents, "NSDate 'dc_dateWithComponents' function isn't working properly")
        XCTAssertEqual(newDate3, dateWithAllComponents, "NSDate 'dc_dateWithComponents' function isn't working properly")
    }
    
    func testWeekday() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Weekday, fromDate: NSDate())
        
        XCTAssertEqual(components.weekday, NSDate().dc_weekday(), "NSDate 'dc_weekday' function isn't working properly")
    }
    
    func testWeekdayOrdinal() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.WeekdayOrdinal, fromDate: NSDate())
        
        XCTAssertEqual(components.weekdayOrdinal, NSDate().dc_weekdayOrdinal(), "NSDate 'dc_weekdayOrdinal' function isn't working properly")
    }
    
    func testWeekOfMonth() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.WeekOfMonth, fromDate: NSDate())
        
        XCTAssertEqual(components.weekOfMonth, NSDate().dc_weekOfMonth(), "NSDate 'dc_weekOfMonth' function isn't working properly")
    }
    
    func testWeekOfYear() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.WeekOfYear, fromDate: NSDate())
        
        XCTAssertEqual(components.weekOfYear, NSDate().dc_weekOfYear(), "NSDate 'dc_weekOfYear' function isn't working properly")
    }
    
    func testDayEra() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Era, fromDate: NSDate())
        
        XCTAssertEqual(components.era, NSDate().dc_era(),"NSDate 'dc_era' function isn't working properly")
    }
    
    func testYear() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Year, fromDate: NSDate())
        
        XCTAssertEqual(components.year, NSDate().dc_year(), "NSDate 'dc_year' function isn't working properly")
    }
    
    func testAddingMonths() {

        let calendar = NSCalendar.currentCalendar()
        
        let components = NSDateComponents()
        components.month = 10
        let date1 = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: NSDate(), options: NSCalendarOptions())
        let date2 = NSDate().dc_dateByAddingMonths(10)
        
        let components1 = calendar.components(.Month, fromDate: date1!)
        let components2 = calendar.components(.Month, fromDate: date2)
        
        XCTAssertEqual(components1, components2, "NSDate 'dc_dateByAddingMonths' function isn't working properly")
    }
    
    func testDaysInMonth() {
        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        
        let days = cal.rangeOfUnit(.Day, inUnit: .Month, forDate: date).length
        
        XCTAssertEqual(days, date.dc_daysInMonth(), "NSDate 'dc_daysInMonth' function isn't working properly")
    }
    
    func testDaysInYear() {
        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        
        let days = cal.rangeOfUnit(.Day, inUnit: .Year, forDate: date).length
        
        XCTAssertEqual(days, date.dc_daysInYear(), "NSDate 'dc_daysInYear' function isn't working properly")
    }
    
    func testDayOfYear() {
        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        
        let days = cal.rangeOfUnit(.Day, inUnit: .Year, forDate: date).location
        
        XCTAssertEqual(days, date.dc_dayOfYear(), "NSDate 'dc_dayOfYear' function isn't working properly")
    }
    
    func testNumberOfDaysBetweenDates() {
        let date1 = NSDate()
        let date2 = NSDate().dc_dateByAddingDays(10)
        
        XCTAssertEqual(date1.dc_numberOfDaysBetween(date2), 10, "NSDate 'dc_dateByAddingDays' function isn't working properly")
    }
    
    func testFirstDayOfWeek() {
        let components = NSDateComponents()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        components.year = 2015
        components.day = 20
        components.month = 10
    
        let testDateInWeek = calendar.dateFromComponents(components)!
        
        components.day = 18 + calendar.firstWeekday - 1
        
        let firstDayOfWeek = calendar.dateFromComponents(components)!
        
        XCTAssertTrue(firstDayOfWeek == NSDate.dc_firstDayOfWeek(testDateInWeek), "Wrong first day of the week")
    }
    
    func testLastDayOfWeek() {
        let components = NSDateComponents()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        components.year = 2015
        components.day = 20
        components.month = 10
        
        let testDateInWeek = calendar.dateFromComponents(components)!
        
        components.day = 25 + calendar.firstWeekday - 1
        
        let lastDayOfWeek = calendar.dateFromComponents(components)!
        
        XCTAssertTrue(lastDayOfWeek == NSDate.dc_lastDayOfWeek(testDateInWeek), "Wrong last day of the week")
    }

    
    func testFirstDayOfMonth() {
        
        let components = NSDateComponents()
        
        components.year = 2015
        components.day = 30
        components.month = 10
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        calendar.timeZone = NSTimeZone.localTimeZone()
        
        let testDateInMonth = calendar.dateFromComponents(components)!

        components.day = 1
        
        let firstDayOfMonth = calendar.dateFromComponents(components)!
        
        XCTAssertTrue(firstDayOfMonth == NSDate.dc_firstDayOfMonth(testDateInMonth), "First day in month is not the same")
    }
    
    func testLastDayOfMonth() {
        let components = NSDateComponents()
        
        components.year = 2015
        components.day = 30
        components.month = 10
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        calendar.timeZone = NSTimeZone.localTimeZone()
        
        let testDateInMonth = calendar.dateFromComponents(components)!
        
        components.day = 31
        
        let lastDayInMonth = calendar.dateFromComponents(components)!
        
        XCTAssertTrue(lastDayInMonth == NSDate.dc_lastDayOfMonth(testDateInMonth), "Last date in month is not correct")
    }
    
    func testCompareSameWeek() {
        let components = NSDateComponents()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        components.year = 2015
        components.day = 30
        components.month = 10
        
        let date1InWeek = calendar.dateFromComponents(components)!
        
        components.day = 29
        
        let date2InWeek = calendar.dateFromComponents(components)!
        
        components.year = 2011
        
        let dateNotInWeek = calendar.dateFromComponents(components)!
        
        XCTAssertTrue(NSDate.dc_compareDates(isSameWeek: date1InWeek, date2: date2InWeek), "Should be in the same week")
        XCTAssertFalse(NSDate.dc_compareDates(isSameWeek: date1InWeek, date2: dateNotInWeek), "Should not be in the same week")
    }
}
