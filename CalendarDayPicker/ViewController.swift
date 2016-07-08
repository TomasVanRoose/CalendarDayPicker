//
//  ViewController.swift
//  CalendarDayPicker
//
//  Created by Tomas Van Roose on 05/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var monthView: MonthViewPicker? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let season = SeasonViewPicker.init(frame: CGRect(x: 20, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height), beginDate: Date(), endDate: Date(timeInterval: 60*60*24*30*10, since: Date()))
        
        self.view.addSubview(season)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

