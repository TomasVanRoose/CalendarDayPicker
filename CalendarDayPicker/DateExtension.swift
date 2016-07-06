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
    
    
    func firstDayOfMonth() -> NSDate? {
        guard
            let cal: Calendar = Calendar.current(),
            var comp: DateComponents = cal.components([.year, .month], from: self) else {return nil}
        
        comp.to12pm()
        
        return cal.date(from: comp)!
    }
    
    
}
