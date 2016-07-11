//
//  ViewController.swift
//  CalendarDayPicker
//
//  Created by Tomas Van Roose on 05/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let season = SeasonViewPicker.init(frame: CGRect(x: 20, y: 20, width: self.view.frame.size.width, height: 500), beginDate: Date(), endDate: Date(timeInterval: 60*60*24*30*10, since: Date())) { date, color, seasonPicker in
            
            var component = DateComponents()
            component.weekOfYear = 2
            
            if !color.isEqual(UIColor.black()) {
                _ = seasonPicker.selectSubsequentDates(forDate: date, andComponent: component, color: UIColor.black())
            } else {
                _ = seasonPicker.selectSubsequentDates(forDate: date, andComponent: component, color: UIColor.green())
            }
            
        }
        
        self.view.addSubview(season)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

