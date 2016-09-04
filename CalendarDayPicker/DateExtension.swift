//
//  DateExtension.swift
//  CalendarDayPicker
//
//  Created by Tomas Van Roose on 05/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import Foundation

internal extension NSDateComponents {
    
    func to12pm() -> (NSDateComponents) {
        self.hour = 12
        self.minute = 0
        self.second = 0
        return self
    }
}

extension NSDate {

    
    static func weekdays() -> [String] {
        return [ "Ma", "Di", "Wo", "Do", "Vr", "Za", "Zo"]
    }
    
    func localMonth() -> String {
        
        let formatter = NSDateFormatter.init()
        let months = formatter.monthSymbols
        let component = NSCalendar.currentCalendar().component(.Month, fromDate: self)
        
        return (months![component - 1] as String).capitalizedString
        
    }
    
    func firstDayOfMonth() -> NSDate? {
        
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            var comp: NSDateComponents = cal.components([.Year, .Month], fromDate: self)
            else {
                return nil
        }
        
        comp = comp.to12pm()
        
        return cal.dateFromComponents(comp)!
    }
    
    func nextDay() -> NSDate {
        
        let dayComponent = NSDateComponents.init()
        dayComponent.day = 1;
        let calendar = NSCalendar.currentCalendar()
        
        return calendar.dateByAddingComponents(dayComponent, toDate: self, options: NSCalendarOptions.init(rawValue: UInt(0)))!
        
    }
    
    func nextMonth() -> NSDate {
        let monthComponent = NSDateComponents.init()
        monthComponent.month = 1
        let calendar = NSCalendar.currentCalendar()
        
        return calendar.dateByAddingComponents(monthComponent, toDate: self, options: NSCalendarOptions.init(rawValue: UInt(0)))!
    }
    
    func year() -> Int {
        return NSCalendar.currentCalendar().component(.Year, fromDate: self)
    }
    
    func month() -> Int {
        return NSCalendar.currentCalendar().component(.Month, fromDate: self)
    }
    
    func weekday() -> Int {
        let weekday = NSCalendar.currentCalendar().component(.Weekday, fromDate: self)
        
        return (weekday + 7 - NSCalendar.currentCalendar().firstWeekday) % 7 + 1
    }
    
    func monthday() -> Int {
        return NSCalendar.currentCalendar().component(.Day, fromDate: self)
    }
    
    func weekOfMonth() -> Int {
        return NSCalendar.currentCalendar().component(.WeekOfMonth, fromDate: self)
    }
    
    func compareDays(date: NSDate) -> NSComparisonResult {
        return NSCalendar.currentCalendar().compareDate(self, toDate: date, toUnitGranularity: .Day)
    }
    
    func compareMonths(date: NSDate) -> NSComparisonResult {
        return NSCalendar.currentCalendar().compareDate(self, toDate: date, toUnitGranularity: .Month)
    }
    
}
