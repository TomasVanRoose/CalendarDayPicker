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

        let firstview = MonthViewPicker.init(origin: CGPoint.init(x: 20, y:20), date: Date())
        
        let view = MonthViewPicker.init(origin: CGPoint.init(x: firstview.bounds.size.width + 50, y: 20), date: Date.init(timeInterval: 60*60*24*31, since: Date()))
        
        //developer
        self.view.addSubview(firstview)
        self.view.addSubview(view)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

