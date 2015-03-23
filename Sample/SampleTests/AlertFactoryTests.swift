//
//  AlertFactoryTests.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 22/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation
import UIKit
import XCTest
import Sample

class AlertFactoryTests: XCTestCase {
    
    func testAlertFactory() {
        let alert = AlertFactory.confirmationWithTitle("Mock title", message: "Mock message") { (action) -> Void in
            
        }
        
        XCTAssertEqual(alert.title!, "Mock title", "")
        XCTAssertEqual(alert.message!, "Mock message", "")
        XCTAssertTrue(alert.actions.count == 2, "")
    }
}