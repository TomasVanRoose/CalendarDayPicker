//
//  MonthViewPicker.swift
//  CalendarDayPicker
//
//  Created by Tomas Van Roose on 05/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import UIKit


class MonthViewPicker: UIView {

    internal static let labelHeight = 25
    internal static let labelWidth = 25
    internal static let padding = 8
    
    static let totalWidth = 7 * (labelWidth + padding) - padding

    
    internal var month = 0
    internal var year = 0
    
    let firstDay: NSDate
    
    // Delegation function
    var didSelectDateFunc: ((NSDate, UIColor) -> ())?
    
    
    // MARK: Public Functions
    
    func selectDate(date: NSDate, color: UIColor) -> Bool {
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Month, .Year, .Day], fromDate: date)
        
        if (components.year == year && components.month == month) {
            
            let label = viewWithTag(components.day) as! UILabel
            
            label.textColor = color
            
            return true
            
        }
        
        return false
    }
    
    // MARK: Initialization methods
    
    init(origin: CGPoint, date: NSDate, dateSelectedFunc: ((NSDate, UIColor) -> ())?) {
        
        var verticalOffset = 0
        didSelectDateFunc = dateSelectedFunc
        
        firstDay = date.firstDayOfMonth()!
        
        super.init(frame: CGRect.init(x: origin.x, y: origin.y, width: CGFloat(MonthViewPicker.totalWidth), height: 0))
        
        month = date.month()
        year = date.year()
        
        // Draw name of the month
        let monthName = date.localMonth()
        
        let monthNameLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: CGFloat(MonthViewPicker.totalWidth), height: 30))
        monthNameLabel.text = monthName
        
        self.addSubview(monthNameLabel)
        verticalOffset += Int(monthNameLabel.frame.size.height) + MonthViewPicker.padding
        
        // Draw the names of the day of the week
        let weekdays = NSDate.weekdays()
        
        for i in 0...weekdays.count-1 {
            
            self.addSubview(makeStringLabel(weekdays[i], origin: CGPoint.init(x: i * (MonthViewPicker.labelWidth + MonthViewPicker.padding), y: verticalOffset)))
        }
        verticalOffset += MonthViewPicker.labelHeight + MonthViewPicker.padding
        
        var day = firstDay
        
        // If first day of the month is not on a monday then weekofthemonth equals 0, but for placement we want all firsts to be in week 1
        var offset = 0
        if day.weekOfMonth() == 0 { offset = 1 }
        
        // Variable to remember the furthest y position to calculate total height of monthview
        var y = 0
        
        while day.compareMonths(firstDay) == NSComparisonResult.OrderedSame {
            
            // Weekday range is 1...7, because we want to start the x-coordinate at 0, we subtract
            let x = (day.weekday() - 1) * (MonthViewPicker.labelWidth + MonthViewPicker.padding)
            // Use offset so first week starts at 0
            y = verticalOffset + (day.weekOfMonth() - 1 + offset) * MonthViewPicker.labelHeight
            
            let origin = CGPoint.init(x: x, y: y)
            let label = makeDayLabel(day.monthday(), origin: origin)
            
            self.addSubview(label)
            
            day = day.nextDay()
        }
       
        // Fix the height of the view
        self.frame = CGRect.init(x: origin.x, y: origin.y, width: CGFloat(MonthViewPicker.totalWidth), height: CGFloat(y + MonthViewPicker.labelHeight))
        
    }

    
    @objc private func labelTapped(sender: UITapGestureRecognizer) {
        
        if let dateFunc = didSelectDateFunc {
            
            let label = sender.view as! UILabel
            
            let calendar = NSCalendar.currentCalendar()
            var components = NSDateComponents()
            components.day = label.tag
            components.month = month
            components.year = year
            
            components = components.to12pm()
            
            let date = calendar.dateFromComponents(components)!
            
            dateFunc(date, label.textColor)
        }
        
    }

    
    // Factory for the labels of the names of the weekdays
    private func makeStringLabel(text: String, origin: CGPoint) -> UILabel {
        
        let label = UILabel.init(frame: CGRect.init(x: origin.x, y: origin.y, width: CGFloat(MonthViewPicker.labelWidth), height: CGFloat(MonthViewPicker.labelHeight)))
    
        label.text = text
        label.textColor = UIColor.blueColor()
        label.textAlignment = .Center

        return label
    }
    
    // Factory for the labels of the weekdays
    private func makeDayLabel(number: Int, origin: CGPoint) -> UILabel {
        
        let label = UILabel.init(frame: CGRect.init(x: origin.x, y: origin.y, width: CGFloat(MonthViewPicker.labelWidth), height: CGFloat(MonthViewPicker.labelHeight)))
        
        label.text = String(number)
        label.tag = number
        label.textAlignment = .Center
        label.userInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(MonthViewPicker.labelTapped(_:)))
        label.addGestureRecognizer(gesture)
        
        return label
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
