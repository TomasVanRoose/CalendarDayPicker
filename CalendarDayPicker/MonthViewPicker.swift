//
//  MonthViewPicker.swift
//  CalendarDayPicker
//
//  Created by Tomas Van Roose on 05/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import UIKit

class MonthViewPicker: UIView {

    let labelHeight = 25
    let labelWidth = 25
    let padding = 5
    
    init(origin: CGPoint, date: NSDate) {
        
        let totalWidth = CGFloat(7 * (labelWidth + padding) - padding)
        
        super.init(frame: CGRect.init(x: origin.x, y: origin.y, width: totalWidth, height: 100))
        
        let weekdays = NSDate.weekdays()
        
        for i in 0...weekdays.count-1 {
            self.addSubview(makeLabel(text: weekdays[i], origin: CGPoint.init(x: i * (labelWidth + 5), y: 0)))
        }
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    func makeLabel(text: String, origin: CGPoint) -> UILabel {
        
        
        let label = UILabel.init(frame: CGRect.init(x: origin.x, y: origin.y, width: CGFloat(labelWidth), height: CGFloat(labelHeight)));
        
        label.text = text
        label.textAlignment = .center

        return label
        
    }

}
