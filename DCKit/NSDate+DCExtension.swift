//
//  NSDate+DCExtension.swift
//  CroTourism
//
//  Created by Marko Strizic on 27/05/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import Foundation



private var calendar:NSCalendar = NSCalendar.current as NSCalendar

private let normalizedDateFlags: NSCalendar.Unit = [.year, .month, .day]

private var normalizedCalendar: NSCalendar = {
 
    let calendar: NSCalendar = NSCalendar(identifier: .gregorian)!
    
    calendar.timeZone = TimeZone(abbreviation: "UTC")!

    return calendar
}()

public extension NSDate {

    public class func dc_is24HourModeEnabled() -> Bool {
        if let format = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current) {
            let formatString = format as NSString
            let is24Hour = formatString.range(of: "a").location == NSNotFound
            return is24Hour
        }
        return true
    }


    
    
    public func dc_isSameDay(_ otherDate: NSDate) -> Bool {
        let calendarFlags:NSCalendar.Unit = [.year, .month, .day]
        
        let date1Components = calendar.components(calendarFlags, from: self as Date)
        let date2Components = calendar.components(calendarFlags, from: otherDate as Date)
        
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


    public func dc_numberOfUnits(_ calendarUnits:NSCalendar.Unit) -> NSDateComponents {
        
        let components = calendar.components(calendarUnits, from: self as Date)
        return components as NSDateComponents
    }

    public func dc_numberOfUnits(_ calendarUnit:NSCalendar.Unit, inLargerUnit:NSCalendar.Unit) -> (ordinal:Int, length:Int) {
        
        let days = calendar.range(of: calendarUnit, in: inLargerUnit, for: self as Date)
        return (days.location, days.length)
    }

    public func dc_dateByAddingDays(_ days:Int) -> NSDate {
        
        let dateCompnents = NSDateComponents()
        dateCompnents.day = days
        let newDate = calendar.date(byAdding: dateCompnents as DateComponents, to: self as Date, options: NSCalendar.Options())
        return newDate! as NSDate
    }

    public func dc_dateByAddingMonths(_ months:Int) -> NSDate {
        
        let dateCompnents = NSDateComponents()
        dateCompnents.month = months
        let newDate = calendar.date(byAdding: dateCompnents as DateComponents, to: self as Date, options: NSCalendar.Options())
        return newDate! as NSDate
    }


    public func dc_era() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.era).era
    }

    public func dc_year() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.year).year
    }

    public func dc_month() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.month).month
    }
    
    public func dc_day() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.day).day
    }
    
    public func dc_hour() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.hour).hour
    }
    
    public func dc_minute() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.minute).minute
    }

    /** If you pass nil as parameter, component will be ignored */
    public func dc_dateWithComponents(_ year:Int?=nil, month:Int?=nil, day:Int?=nil, hour:Int?=nil, minute:Int?=nil, second:Int?=nil) -> NSDate? {
        
        let calendarUnits: NSCalendar.Unit = [.era, .year, .month, .day, .hour, .minute, .second]

        var components = calendar.components(calendarUnits, from: self as Date)
        components.year     = year ?? components.year
        components.month    = month ?? components.month
        components.day      = day ?? components.day
        components.hour     = hour ?? components.hour
        components.minute   = minute ?? components.minute
        components.second   = second ?? components.second
        
        let newDate = calendar.date(from: components)
        
        return newDate as NSDate?
    }

    
    
    
    public func dc_second() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.second).second
    }

    public func dc_weekday() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.weekday).weekday
    }
    
    public func dc_weekdayOrdinal() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.weekdayOrdinal).weekdayOrdinal
    }
    
    public func dc_weekOfMonth() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.weekOfMonth).weekOfMonth
    }

    public func dc_weekOfYear() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.weekOfYear).weekOfYear
    }
    
    
    public func dc_daysInMonth() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.day, inLargerUnit: NSCalendar.Unit.month).length
    }

    public func dc_daysInYear() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.day, inLargerUnit: NSCalendar.Unit.year).length
    }

    public func dc_dayOfYear() -> Int {
        return dc_numberOfUnits(NSCalendar.Unit.day, inLargerUnit: NSCalendar.Unit.year).ordinal
    }

    /** Returns input date with HH:MM:SS reset to it's midnight, eg. 21/9/2015 21:21:21 -> 21/9/2015 00:00:00 */
    public func dc_normalizedDate() -> NSDate {
        let components = normalizedCalendar.components(normalizedDateFlags, from: self as Date)
        return normalizedCalendar.date(from: components)! as NSDate
    }
}

public extension NSDate {
    
    public func dc_numberOfDaysBetween(_ secondDate:NSDate) -> Int {
        
        let dateComponents = calendar.components(NSCalendar.Unit.day, from: self as Date, to: secondDate as Date, options: NSCalendar.Options.matchFirst)
        return dateComponents.day!
    }

    public func dc_firstDayOfWeek() -> NSDate {
        var startOfWeek:NSDate?
        var duration: TimeInterval = 0
        calendar.range(of: NSCalendar.Unit.weekOfYear, start: &startOfWeek,interval:&duration, for: self as Date)
        
        return startOfWeek!
    }

    public func dc_lastDayOfWeek() -> NSDate {
        var startOfWeek:NSDate?
        var duration: TimeInterval = 0
        calendar.range(of: NSCalendar.Unit.weekOfYear, start: &startOfWeek,interval:&duration, for: self as Date)
        
        return startOfWeek!.addingTimeInterval(duration)
    }
    
    public func dc_firstDayOfMonth() -> NSDate {
        var startDate:NSDate?
        var duration: TimeInterval = 0
        calendar.range(of: NSCalendar.Unit.month, start: &startDate,interval:&duration, for: self as Date)
        
        return startDate!
    }

    public func dc_lastDayOfMonth() -> NSDate {
        
        let dayCount = calendar.range(of: .day, in: .month, for: self as Date).length
        var components = calendar.components([.year, .month, .day], from: self as Date)
        
        components.day = dayCount
        
        return calendar.date(from: components)! as NSDate
    }
    
    public func dc_isSameWeek(_ anotherDate:NSDate) -> Bool {
        
        let calendarFlags:NSCalendar.Unit = [.weekOfYear, .yearForWeekOfYear]
        
        let date1Components = calendar.components(calendarFlags, from: self as Date)
        let date2Components = calendar.components(calendarFlags, from: anotherDate as Date)
        
        if date1Components.weekOfYear == date2Components.weekOfYear
            && date1Components.yearForWeekOfYear == date2Components.yearForWeekOfYear {
                return true
        }
        return false
    }

    public func dc_isSameWeekday(_ date: NSDate) -> Bool {
        
        let calendarFlags: NSCalendar.Unit = [.weekday]
        
        let date1Components = calendar.components(calendarFlags, from: self as Date)
        let date2Components = calendar.components(calendarFlags, from: date as Date)
        
        if date1Components.weekday == date2Components.weekday {
            return true
        }
        
        return false
    }


}
