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
    func didSelectDate(date: Date)
}


class MonthViewPicker: UIView {

    internal let labelHeight = 25
    internal let labelWidth = 25
    internal let padding = 8
    
    internal var month = 0
    internal var year = 0
    
    weak var delegate : MonthViewPickerDelegate?
    
    
    /* Public Functions */
    
    func selectDate(date: Date, color: UIColor) -> Bool {
        
        let calendar = Calendar.current()
        let components = calendar.components([.month, .year, .day], from: date)
        
        if (components.year == year && components.month == month) {
            
            let label = viewWithTag(components.day!) as! UILabel
            
            label.textColor = color
            
            return true
            
        }
        
        return false
    }
    
    
    init(origin: CGPoint, date: Date) {
        
        var verticalOffset = 0
        
        let totalWidth = CGFloat(7 * (labelWidth + padding) - padding)
        
        super.init(frame: CGRect.init(x: origin.x, y: origin.y, width: totalWidth, height: 0))
        
        month = date.month()
        year = date.year()
        
        // Draw name of the month
        let monthName = date.localMonth()
        
        let monthNameLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: totalWidth, height: 30))
        monthNameLabel.text = monthName
        
        self.addSubview(monthNameLabel)
        verticalOffset += Int(monthNameLabel.frame.size.height) + padding
        
        // Draw the names of the day of the week
        let weekdays = Date.weekdays()
        
        for i in 0...weekdays.count-1 {
            
            self.addSubview(makeStringLabel(text: weekdays[i], origin: CGPoint.init(x: i * (labelWidth + padding), y: verticalOffset)))
        }
        verticalOffset += labelHeight + padding
        
        // Get first day of the month
        let firstDayOfMonth = date.firstDayOfMonth()!
        
        var day = firstDayOfMonth
        
        // If first day of the month is not on a monday then weekofthemonth equals 0, but for placement we want all firsts to be in week 1
        var offset = 0
        if day.weekOfMonth() == 0 { offset = 1 }
        
        // Variable to remember the furthest y position to calculate total height of monthview
        var y = 0
        
        while day.compareMonths(date: firstDayOfMonth) == ComparisonResult.orderedSame {
            
            // Weekday range is 1...7, because we want to start the x-coordinate at 0, we subtract
            let x = (day.weekday() - 1) * (labelWidth + padding)
            // Use offset so first week starts at 0
            y = verticalOffset + (day.weekOfMonth() - 1 + offset) * labelHeight
            
            let origin = CGPoint.init(x: x, y: y)
            let label = makeDayLabel(number: day.monthday(), origin: origin)
            
            self.addSubview(label)
            
            day = day.nextDay()
        }
       
        self.frame = CGRect.init(x: origin.x, y: origin.y, width: totalWidth, height: CGFloat(y + labelHeight))
        
    }

    
    @objc private func labelTapped(sender: UITapGestureRecognizer) {
        let tag = sender.view!.tag
        
        let calendar = Calendar.current()
        var components = DateComponents()
        components.day = tag
        components.month = month
        components.year = year
        
        components.to12pm()
        
        let date = calendar.date(from: components)!
        
        delegate?.didSelectDate(date: date)
        
    }

    
    // Factory for the labels of the names of the weekdays
    private func makeStringLabel(text: String, origin: CGPoint) -> UILabel {
        
        let label = UILabel.init(frame: CGRect.init(x: origin.x, y: origin.y, width: CGFloat(labelWidth), height: CGFloat(labelHeight)))
    
        label.text = text
        label.textAlignment = .center

        return label
    }
    
    // Factory for the labels of the weekdays
    private func makeDayLabel(number: Int, origin: CGPoint) -> UILabel {
        
        let label = UILabel.init(frame: CGRect.init(x: origin.x, y: origin.y, width: CGFloat(labelWidth), height: CGFloat(labelHeight)))
        
        label.text = String(number)
        label.tag = number
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(MonthViewPicker.labelTapped(sender:)))
        label.addGestureRecognizer(gesture)
        
        return label
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
