//
//  SeasonViewPicker.swift
//  CalendarDayPicker
//
//  Created by Tomas Van Roose on 07/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import UIKit

class SeasonViewPicker: UIView, MonthViewPickerDelegate {

    
    internal let padding = 20
    
    func didSelectDate(date: Date) {
        // TODO
    }
    
    
    init(frame: CGRect, beginDate: Date, endDate: Date) {
        
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
            
            self.addSubview(monthView)
            currentDate = currentDate.nextMonth()
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
