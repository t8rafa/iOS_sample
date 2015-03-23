//
//  ExtensionTests.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 22/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation
import XCTest
import Sample

class ExtensionTests: XCTestCase {
    func testValidEmail() {
        let email = "mock@mock.com"
        
        XCTAssertTrue(email.isValidEmail(), "")
    }
    
    func testInvalidEmail() {
        let email = "mock@mock"
        
        XCTAssertFalse(email.isValidEmail(), "")
    }
}