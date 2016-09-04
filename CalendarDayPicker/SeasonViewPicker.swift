//
//  SeasonViewPicker.swift
//  CalendarDayPicker
//
//  Created by Tomas Van Roose on 07/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import UIKit


class SeasonViewPicker: UIView {

    
    internal let padding = 20
    internal let beginDate: NSDate
    internal let endDate: NSDate
    
    var monthViews = [MonthViewPicker]()
    
    var didSelectDateFunc: ((NSDate, UIColor, SeasonViewPicker) -> ())?
    
    
    // MARK: Public functions
    
    func selectDate(date: NSDate, color: UIColor) -> Bool {
        
        if (date.compareDays(beginDate) == NSComparisonResult.OrderedAscending || date.compareDays(endDate) == NSComparisonResult.OrderedDescending) {
            return false
        }
        for picker in monthViews {
            
            if (picker.firstDay.compareMonths(date) == NSComparisonResult.OrderedSame) {
                return picker.selectDate(date, color: color)
            }
        }
        
        return false
    }
    
    func selectSubsequentDates(forDate: NSDate, andComponent: NSDateComponents, color: UIColor) -> Bool {
        
        var currentDate = forDate
        let cal = NSCalendar.currentCalendar()
        
        while currentDate.compareDays(endDate) == NSComparisonResult.OrderedAscending ||
            currentDate.compareDays(endDate) == NSComparisonResult.OrderedSame {
            
                if selectDate(currentDate, color: color) == false {
                    return false;
                }
            currentDate = cal.dateByAddingComponents(andComponent, toDate: currentDate, options: NSCalendarOptions.init(rawValue: UInt(0)))!
        }
        
        return true;
    }
    
    // MARK: Initialization functions
    
    init(frame: CGRect, beginDate: NSDate, endDate: NSDate, dateFunc: ((NSDate, UIColor, SeasonViewPicker) ->())?) {
        
        self.beginDate = beginDate
        self.endDate = endDate
        
        self.didSelectDateFunc = dateFunc
        
        super.init(frame: frame)
        
        // Init scrollview
        let scrollView = UIScrollView(frame: frame)
        scrollView.alwaysBounceHorizontal = false
        addSubview(scrollView)
        
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
        
        while currentDate.compareMonths(endDate) == NSComparisonResult.OrderedAscending || currentDate.compareMonths(endDate) == NSComparisonResult.OrderedSame {
            
            let origin = CGPoint(x: column * (monthViewWidth + padding), y: rowHeight)
            
            let monthView = MonthViewPicker.init(origin: origin, date: currentDate) {[ unowned me = self] date, color in
                // delegate the selection to creator of this view
                if let dateFunc = me.didSelectDateFunc {
                    dateFunc(date, color, me)
                }
                
            }
            
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
            
            scrollView.addSubview(monthView)
            monthViews.append(monthView)
            currentDate = currentDate.nextMonth()
            
        }
        
        _ = selectDate(beginDate, color: UIColor.redColor())
        _ = selectDate(endDate, color: UIColor.redColor())
        
        scrollView.contentSize = CGSize(width: frame.size.width, height: CGFloat(rowHeight + maxHeightOfCurrentRow))
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
