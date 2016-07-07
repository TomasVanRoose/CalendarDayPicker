//
//  ViewController.swift
//  CalendarDayPicker
//
//  Created by Tomas Van Roose on 05/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MonthViewPickerDelegate {

    
    var monthView: MonthViewPicker? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        monthView = MonthViewPicker.init(origin: CGPoint.init(x: 20, y:20), date: Date())
        monthView!.delegate = self
        
        let view = MonthViewPicker.init(origin: CGPoint.init(x: monthView!.bounds.size.width + 50, y: 20), date: Date.init(timeInterval: 60*60*24*31, since: Date()))
        
        //developer
        self.view.addSubview(monthView!)
        self.view.addSubview(view)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectDate(date: Date) {
        monthView!.selectDate(date: date, color: UIColor.red())
    }


}

