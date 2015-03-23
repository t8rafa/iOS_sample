//
//  ResponseTests.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 22/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation
import XCTest
import Sample

class ResponseTests: XCTestCase {
    
    func testInstanceOfResponse() {
        let expected = Response()
        
        XCTAssertEqual(expected.code, 0, "")
        XCTAssertEqual(expected.status, "", "")
        XCTAssertEqual(expected.message, "", "")
    }
}