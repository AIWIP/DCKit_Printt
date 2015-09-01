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
        var calendarFlags:NSCalendarUnit = .YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit
        
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
        return dc_numberOfUnits(NSCalendarUnit.EraCalendarUnit).era
    }
    
    public func dc_year() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.YearCalendarUnit).year
    }
    
    public func dc_month() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.MonthCalendarUnit).month
    }
    
    public func dc_day() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.DayCalendarUnit).day
    }
    
    public func dc_hour() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.HourCalendarUnit).hour
    }
    
    public func dc_minute() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.MinuteCalendarUnit).minute
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
        return dc_numberOfUnits(NSCalendarUnit.SecondCalendarUnit).second
    }
    
    public func dc_weekday() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.WeekdayCalendarUnit).weekday
    }
    
    public func dc_weekdayOrdinal() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.WeekdayOrdinalCalendarUnit).weekdayOrdinal
    }
    
    public func dc_weekOfMonth() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.WeekOfMonthCalendarUnit).weekOfMonth
    }

    public func dc_weekOfYear() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.WeekOfYearCalendarUnit).weekOfYear
    }
    
    
    public func dc_daysInMonth() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.DayCalendarUnit, inLargerUnit: NSCalendarUnit.MonthCalendarUnit).length
    }
    
    public func dc_daysInYear() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.DayCalendarUnit, inLargerUnit: NSCalendarUnit.YearCalendarUnit).length
    }
    
    public func dc_dayOfYear() -> Int {
        return dc_numberOfUnits(NSCalendarUnit.DayCalendarUnit, inLargerUnit: NSCalendarUnit.YearCalendarUnit).ordinal
    }
    
}

public extension NSDate {

    
    public func dc_numberOfDaysBetween(secondDate:NSDate) -> Int {
        
        let dateComponents = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: self, toDate: secondDate, options: NSCalendarOptions.MatchFirst)
        return dateComponents.day
        
    }



}
