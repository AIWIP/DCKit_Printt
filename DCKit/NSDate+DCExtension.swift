//
//  NSDate+DCExtension.swift
//  CroTourism
//
//  Created by Marko Strizic on 27/05/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import Foundation



private var calendar:NSCalendar! = NSCalendar.currentCalendar()

private let normalizedDateFlags: NSCalendarUnit = [.Year, .Month, .Day]

private var normalizedCalendar: NSCalendar = {
 
    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    calendar.timeZone = NSTimeZone(abbreviation: "UTC")!

    return calendar
}()

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
        let calendarFlags:NSCalendarUnit = [.Year, .Month, .Day]
        
        let date1Components = calendar.components(calendarFlags, fromDate: self)
        let date2Components = calendar.components(calendarFlags, fromDate: otherDate)
        
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
        
        let dateCompnents = NSDateComponents()
        dateCompnents.day = days
        let newDate = calendar.dateByAddingComponents(dateCompnents, toDate: self, options: NSCalendarOptions())
        return newDate!
    }
    
    public func dc_dateByAddingMonths(months:Int) -> NSDate {
        
        let dateCompnents = NSDateComponents()
        dateCompnents.month = months
        let newDate = calendar.dateByAddingComponents(dateCompnents, toDate: self, options: NSCalendarOptions())
        return newDate!
    }
    
    
    public func dc_era() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.Era).era
    }
    
    public func dc_year() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.Year).year
    }
    
    public func dc_month() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.Month).month
    }
    
    public func dc_day() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.Day).day
    }
    
    public func dc_hour() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.Hour).hour
    }
    
    public func dc_minute() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.Minute).minute
    }
    
    /** If you pass nil as parameter, component will be ignored */
    public func dc_dateWithComponents(year:Int?=nil, month:Int?=nil, day:Int?=nil, hour:Int?=nil, minute:Int?=nil, second:Int?=nil) -> NSDate? {
        
        let calendarUnits: NSCalendarUnit = [.Era, .Year, .Month, .Day, .Hour, .Minute, .Second]

        let components = calendar.components(calendarUnits, fromDate: self)
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
        return dc_numberOfUnits(NSCalendarUnit.Second).second
    }
    
    public func dc_weekday() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.Weekday).weekday
    }
    
    public func dc_weekdayOrdinal() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.WeekdayOrdinal).weekdayOrdinal
    }
    
    public func dc_weekOfMonth() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.WeekOfMonth).weekOfMonth
    }

    public func dc_weekOfYear() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.WeekOfYear).weekOfYear
    }
    
    
    public func dc_daysInMonth() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.Day, inLargerUnit: NSCalendarUnit.Month).length
    }
    
    public func dc_daysInYear() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.Day, inLargerUnit: NSCalendarUnit.Year).length
    }
    
    public func dc_dayOfYear() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.Day, inLargerUnit: NSCalendarUnit.Year).ordinal
    }
    
    /** Returns input date with HH:MM:SS reset to it's midnight, eg. 21/9/2015 21:21:21 -> 21/9/2015 00:00:00 */
    public func dc_normalizedDate() -> NSDate {
        let components = normalizedCalendar.components(normalizedDateFlags, fromDate: self)
        return normalizedCalendar.dateFromComponents(components)!
    }
}

public extension NSDate {
    
    public func dc_numberOfDaysBetween(secondDate:NSDate) -> Int {
        
        let dateComponents = calendar.components(NSCalendarUnit.Day, fromDate: self, toDate: secondDate, options: NSCalendarOptions.MatchFirst)
        return dateComponents.day
        
    }

    public func dc_firstDayOfWeek() -> NSDate {
        var startOfWeek:NSDate?
        var duration: NSTimeInterval = 0
        calendar.rangeOfUnit(NSCalendarUnit.WeekOfYear, startDate: &startOfWeek,interval:&duration, forDate: self)
        
        return startOfWeek!
    }
    
    public func dc_lastDayOfWeek() -> NSDate {
        var startOfWeek:NSDate?
        var duration: NSTimeInterval = 0
        calendar.rangeOfUnit(NSCalendarUnit.WeekOfYear, startDate: &startOfWeek,interval:&duration, forDate: self)
        
        return startOfWeek!.dateByAddingTimeInterval(duration)
    }
    
    public func dc_firstDayOfMonth() -> NSDate {
        var startDate:NSDate?
        var duration: NSTimeInterval = 0
        calendar.rangeOfUnit(NSCalendarUnit.Month, startDate: &startDate,interval:&duration, forDate: self)
        
        return startDate!
    }
    
    public func dc_lastDayOfMonth() -> NSDate {
        
        let dayCount = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: self).length
        let components = calendar.components([.Year, .Month, .Day], fromDate: self)
        
        components.day = dayCount
        
        return calendar.dateFromComponents(components)!
    }
    
    public func dc_isSameWeek(anotherDate:NSDate) -> Bool {
        
        let calendarFlags:NSCalendarUnit = [.WeekOfYear, .YearForWeekOfYear]
        
        let date1Components = calendar.components(calendarFlags, fromDate: self)
        let date2Components = calendar.components(calendarFlags, fromDate: anotherDate)
        
        if date1Components.weekOfYear == date2Components.weekOfYear
            && date1Components.yearForWeekOfYear == date2Components.yearForWeekOfYear {
                return true
        }
        return false
    }
    
    public func dc_isSameWeekday(date: NSDate) -> Bool {
        
        let calendarFlags: NSCalendarUnit = [.Weekday]
        
        let date1Components = calendar.components(calendarFlags, fromDate: self)
        let date2Components = calendar.components(calendarFlags, fromDate: date)
        
        if date1Components.weekday == date2Components.weekday {
            return true
        }
        
        return false
    }


}
