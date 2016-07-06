//
//  CalendarDayPickerTests.swift
//  CalendarDayPickerTests
//
//  Created by Tomas Van Roose on 05/07/16.
//  Copyright © 2016 Tomas Van Roose. All rights reserved.
//

import XCTest
@testable import CalendarDayPicker

class CalendarDayPickerTests: XCTestCase {
    
    
    let calendar = Calendar.current()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testFirstDayOfTheMonth() {
        var comp = DateComponents.init()
        comp.year = 2016
        comp.month = 1
        comp.day = 18

        let date = calendar.date(from: comp)!
        let first = date.firstDayOfMonth()!
        
        let firstComp = calendar.components([.year, .month, .day], from: first)
        
        XCTAssertEqual(firstComp.day, 1)
        XCTAssertEqual(firstComp.month, comp.month)
        XCTAssertEqual(firstComp.year, comp.year)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
