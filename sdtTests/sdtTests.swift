//
//  sdtTests.swift
//  sdtTests
//
//  Created by アラ 若菜 on 2017/02/16.
//  Copyright © 2017 wknar. All rights reserved.
//

import XCTest
import UserNotifications

@testable import sdt

class sdtTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let res: UNMutableNotificationContent = AppDelegate().createContentOfAlert()
        XCTAssertEqual(res.title, "千代田区ごみ")
        let weekday = NSCalendar.current.component(Calendar.Component.weekday, from: NSDate() as Date)
        if weekday == 1 {
            XCTAssertTrue(res.subtitle.contains("Monday"))
        }
    }
    
}
