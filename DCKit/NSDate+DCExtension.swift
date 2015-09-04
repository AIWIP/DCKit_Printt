//
//  NSDate+DCExtension.swift
//  CroTourism
//
//  Created by Marko Strizic on 27/05/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import Foundation



private  var calendar:NSCalendar! = NSCalendar.currentCalendar()

public extension NSDate {
    
    public class func dc_is24HourModeEnabled() -> Bool {
    
        if let format = NSDateFormatter.dateFormatFromTemplate("j", options: 0, locale: NSLocale.currentLocale()) {
            
            let formatString = format as NSString
            let is24Hour = formatString.rangeOfString("a").location == NSNotFound
            return is24Hour
        }
        return true
    }
    

    
    
    public func dc_isSameDay(otherDate:NSDate) -> Bool {
        var calendarFlags:NSCalendarUnit = .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay
        
        var date1Components = calendar.components(calendarFlags, fromDate: self)
        var date2Components = calendar.components(calendarFlags, fromDate: otherDate)
        
        if date1Components.year == date2Components.year && date1Components.month == date2Components.month && date1Components.day == date2Components.day {
            return true
        }
        return false
    }
    
    public func dc_isToday() -> Bool {
        return dc_isSameDay(NSDate())
    }
    
    public func dc_isTomorrow() -> Bool {
        return dc_isSameDay(NSDate(timeIntervalSinceNow: 24 * 60 * 60))
    }
    
    
    public func dc_numberOfUnits(calendarUnits:NSCalendarUnit) -> NSDateComponents {
        
        let components = calendar.components(calendarUnits, fromDate: self)
        return components
    }
    
    public func dc_numberOfUnits(calendarUnit:NSCalendarUnit, inLargerUnit:NSCalendarUnit) -> (ordinal:Int, length:Int) {
        
        let days = calendar.rangeOfUnit(calendarUnit, inUnit: inLargerUnit, forDate: self)
        return (days.location, days.length)
    }
    
    public func dc_dateByAddingDays(days:Int) -> NSDate {
        
        var dateCompnents = NSDateComponents()
        dateCompnents.day = days
        let newDate = calendar.dateByAddingComponents(dateCompnents, toDate: self, options: NSCalendarOptions.allZeros)
        return newDate!
    }
    
    public func dc_dateByAddingMonths(months:Int) -> NSDate {
        
        var dateCompnents = NSDateComponents()
        dateCompnents.month = months
        let newDate = calendar.dateByAddingComponents(dateCompnents, toDate: self, options: NSCalendarOptions.allZeros)
        return newDate!
    }
    
    
    public func dc_era() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitEra).era
    }
    
    public func dc_year() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitYear).year
    }
    
    public func dc_month() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitMonth).month
    }
    
    public func dc_day() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitDay).day
    }
    
    public func dc_hour() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitHour).hour
    }
    
    public func dc_minute() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitMinute).minute
    }
    
    /** If you pass nil as parameter, component will be ignored */
    public func dc_dateWithComponents(year:Int?=nil, month:Int?=nil, day:Int?=nil, hour:Int?=nil, minute:Int?=nil, second:Int?=nil) -> NSDate? {
        
        let components = calendar.components(NSCalendarUnit.allZeros, fromDate: self)
        components.year     = year ?? components.year
        components.month    = month ?? components.month
        components.day      = day ?? components.day
        components.hour     = hour ?? components.hour
        components.minute   = minute ?? components.minute
        components.second   = second ?? components.second
        
        let newDate = calendar.dateFromComponents(components)
        return newDate
    }

    
    
    
    public func dc_second() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitSecond).second
    }
    
    public func dc_weekday() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitWeekday).weekday
    }
    
    public func dc_weekdayOrdinal() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitWeekdayOrdinal).weekdayOrdinal
    }
    
    public func dc_weekOfMonth() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitWeekOfMonth).weekOfMonth
    }

    public func dc_weekOfYear() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitWeekOfYear).weekOfYear
    }
    
    
    public func dc_daysInMonth() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitDay, inLargerUnit: NSCalendarUnit.CalendarUnitMonth).length
    }
    
    public func dc_daysInYear() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitDay, inLargerUnit: NSCalendarUnit.CalendarUnitYear).length
    }
    
    public func dc_dayOfYear() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.CalendarUnitDay, inLargerUnit: NSCalendarUnit.CalendarUnitYear).ordinal
    }
    
    /** Returns input date with HH:MM:SS reset to it's midnight, eg. 21/9/2015 21:21:21 -> 21/9/2015 00:00:00 */
    public func dc_normalizedDate() -> NSDate {
        let flags: NSCalendarUnit = .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        calendar.timeZone = NSTimeZone(abbreviation: "UTC")!
        
        let components = calendar.components(flags, fromDate: self)
        return calendar.dateFromComponents(components)!
    }
    
}

public extension NSDate {

    
    public func dc_numberOfDaysBetween(secondDate:NSDate) -> Int {
        
        let dateComponents = calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: self, toDate: secondDate, options: NSCalendarOptions.MatchFirst)
        return dateComponents.day
        
    }



}
