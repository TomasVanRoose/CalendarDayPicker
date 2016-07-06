//
//  DateExtension.swift
//  CalendarDayPicker
//
//  Created by Tomas Van Roose on 05/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import Foundation

internal extension DateComponents {
    
    mutating func to12pm() {
        self.hour = 12
        self.minute = 0
        self.second = 0
    }
}

extension Date {

    
    static func weekdays() -> [String] {
        return [ "Ma", "Di", "Wo", "Do", "Vr", "Za", "Zo"]
    }
    
    
    func firstDayOfMonth() -> Date? {
        
        guard
            let cal: Calendar = Calendar.current(),
            var comp: DateComponents = cal.components([.year, .month], from: self)
            else {
                return nil
        }
        
        comp.to12pm()
        
        return cal.date(from: comp)!
    }
    
    func nextDay() -> Date {
        
        var dayComponent = DateComponents.init()
        dayComponent.day = 1;
        let calendar = Calendar.current()
        
        return calendar.date(byAdding: dayComponent, to: self, options: Calendar.Options(rawValue: UInt(0)))!
        
    }
    
    func weekday() -> Int {
        let weekday = Calendar.current().component(.weekday, from: self)
        
        return (weekday + 7 - Calendar.current().firstWeekday) % 7 + 1
    }
    
    func monthday() -> Int {
        return Calendar.current().component(.day, from: self)
    }
    
    func weekOfMonth() -> Int {
        return Calendar.current().component(.weekOfMonth, from: self)
    }
    
    func compareDays(date: Date) -> ComparisonResult {
        return Calendar.current().compare(self, to: date, toUnitGranularity: .day)
    }
    
    func compareMonths(date: Date) -> ComparisonResult {
        return Calendar.current().compare(self, to: date, toUnitGranularity: .month)
    }
    
}
