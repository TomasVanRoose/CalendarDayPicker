//
//  MonthViewPicker.swift
//  CalendarDayPicker
//
//  Created by Tomas Van Roose on 05/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import UIKit

// MonthViewPickerDelegate
// Notifies when date was selected
protocol MonthViewPickerDelegate: class {
    func didSelectDate(date: NSDate)
}


class MonthViewPicker: UIView {

    let labelHeight = 25
    let labelWidth = 25
    let padding = 5
    
    weak var delegate : MonthViewPickerDelegate?
    
    
    /* Public Functions */
    
    func selectDate(date: NSDate) -> Bool {
        
        // TODO //
        
        return false
    }
    
    
    init(origin: CGPoint, date: Date) {
        
        let totalWidth = CGFloat(7 * (labelWidth + padding) - padding)
        
        super.init(frame: CGRect.init(x: origin.x, y: origin.y, width: totalWidth, height: 200))
        
        // Draw name of the month -> TODO
        
        
        // Draw the names of the day of the week
        let weekdays = Date.weekdays()
        
        for i in 0...weekdays.count-1 {
            
            self.addSubview(makeStringLabel(text: weekdays[i], origin: CGPoint.init(x: i * (labelWidth + padding), y: 0)))
        
        }
        
        // Get first day of the month
        let firstDayOfMonth = date.firstDayOfMonth()!
        
        var day = firstDayOfMonth
        
        // If first day of the month is not on a monday then weekofthemonth equals 0, but for placement we want all firsts to be in week 1
        var offset = 0
        if day.weekOfMonth() == 0 { offset = 1 }
        
        while day.compareMonths(date: firstDayOfMonth) == ComparisonResult.orderedSame {
            
            // Weekday range is 1...7, because we want to start the x-coordinate at 0, we subtract
            let x = (day.weekday() - 1) * (labelWidth + padding)
            // Use offset so first week starts at 0
            let y = (day.weekOfMonth() - 1 + offset) * labelHeight
            
            let origin = CGPoint.init(x: x, y: y)
            let label = makeDayLabel(number: day.monthday(), origin: origin)
            
            self.addSubview(label)
            
            day = day.nextDay()
        }
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // Factory for the labels of the names of the weekdays
    func makeStringLabel(text: String, origin: CGPoint) -> UILabel {
        
        let label = UILabel.init(frame: CGRect.init(x: origin.x, y: origin.y, width: CGFloat(labelWidth), height: CGFloat(labelHeight)))
    
        label.text = text
        label.textAlignment = .center

        return label
    }
    
    // Factory for the labels of the weekdays
    func makeDayLabel(number: Int, origin: CGPoint) -> UILabel {
        
        let label = UILabel.init(frame: CGRect.init(x: origin.x, y: origin.y, width: CGFloat(labelWidth), height: CGFloat(labelHeight)))
        
        label.text = String(number)
        label.tag = number
        label.textAlignment = .center
        
        
        
        return label
    }

}
