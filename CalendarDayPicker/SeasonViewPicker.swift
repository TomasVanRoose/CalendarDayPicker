//
//  SeasonViewPicker.swift
//  CalendarDayPicker
//
//  Created by Tomas Van Roose on 07/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import UIKit

protocol SeasonViewPickerDelegate: class {
    func didSelectDate(date: Date, color: UIColor, picker: SeasonViewPicker)
}


class SeasonViewPicker: UIView, MonthViewPickerDelegate {

    
    internal let padding = 20
    internal let beginDate: Date
    internal let endDate: Date
    
    var monthViews = [MonthViewPicker]()
    
    weak var delegate : SeasonViewPickerDelegate?

    
    // Delegate method
    func didSelectDate(date: Date, color: UIColor, picker: MonthViewPicker) {
        delegate?.didSelectDate(date: date, color: color, picker: self)
    }
    
    func selectDate(date: Date, color: UIColor) -> Bool {
        
        if (date.compareDays(date: beginDate) == ComparisonResult.orderedAscending || date.compareDays(date: endDate) == ComparisonResult.orderedDescending) {
            return false
        }
        
        for picker in monthViews {
            
            if (picker.firstDay.compareMonths(date: date) == ComparisonResult.orderedSame) {
                return picker.selectDate(date: date, color: color)
            }
        }
        
        return false
    }
    
    
    init(frame: CGRect, beginDate: Date, endDate: Date) {
        
        self.beginDate = beginDate
        self.endDate = endDate
        
        super.init(frame: frame)
        
        let monthViewWidth = Int(MonthViewPicker.totalWidth)
        
        let amountPerRow = Int(frame.size.width) / (monthViewWidth + padding)
        
        /* Variables for the loop */
        
        var currentDate = beginDate
        // counter for what column the current monthview should be in
        var column = 0
        // the y-coordinate of current monthview
        var rowHeight = 0
        
        // Keeps track of the highest monthview, that way the next row will all be on the same y
        var maxHeightOfCurrentRow = 0
        
        while currentDate.compareMonths(date: endDate) == ComparisonResult.orderedAscending || currentDate.compareMonths(date: endDate) == ComparisonResult.orderedSame {
            
            let origin = CGPoint(x: column * (monthViewWidth + padding), y: rowHeight)
            
            let monthView = MonthViewPicker.init(origin: origin, date: currentDate)
            
            // Change maxheightofcurrentrow
            if (Int(monthView.frame.size.height) > maxHeightOfCurrentRow) {
                maxHeightOfCurrentRow = Int(monthView.frame.size.height)
            }
            
            column += 1
            
            // Go to next row
            if (column >= amountPerRow) {
                column = 0
                rowHeight += maxHeightOfCurrentRow + padding
                maxHeightOfCurrentRow = 0
            }
            
            monthView.delegate = self
            
            self.addSubview(monthView)
            monthViews.append(monthView)
            currentDate = currentDate.nextMonth()
            
        }
        
        _ = selectDate(date: beginDate, color: UIColor.red())
        _ = selectDate(date: endDate, color: UIColor.red())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
