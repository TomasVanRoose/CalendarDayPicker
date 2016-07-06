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
        
        super.init(frame: CGRect.init(x: origin.x, y: origin.y, width: totalWidth, height: 100))
        
        // Draw name of the month -> TODO
        
        
        // Draw the names of the day of the week
        let weekdays = Date.weekdays()
        
        for i in 0...weekdays.count-1 {
            
            self.addSubview(makeStringLabel(text: weekdays[i], origin: CGPoint.init(x: i * (labelWidth + padding), y: 0)))
        
        }
        
        // Get first day of the month
        
        // See what weekday it is on
        
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    func makeStringLabel(text: String, origin: CGPoint) -> UILabel {
        
        let label = UILabel.init(frame: CGRect.init(x: origin.x, y: origin.y, width: CGFloat(labelWidth), height: CGFloat(labelHeight)));
    
        label.text = text
        label.textAlignment = .center

        return label
    }
    
    //func makeDayLabel(number: Int, origin: CGPoint) -> UILabel {
        
        
        
    //}

}
