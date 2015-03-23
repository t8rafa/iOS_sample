//
//  CandidateTests.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 22/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation
import XCTest
import Sample


class CandidateTests: XCTestCase {
    
    func testCandidateInstance() {
        let candidate = Candidate()
        
        XCTAssertTrue(candidate.name.isEmpty, "")
        XCTAssertTrue(candidate.email.isEmpty, "")
        XCTAssertEqual(candidate.html, 0, "")
        XCTAssertEqual(candidate.css, 0, "")
        XCTAssertEqual(candidate.javaScript, 0, "")
        XCTAssertEqual(candidate.python, 0, "")
        XCTAssertEqual(candidate.django, 0, "")
        XCTAssertEqual(candidate.ios, 0, "")
        XCTAssertEqual(candidate.android, 0, "")
    }
    
    func testCandidateToJosnString() {
        let expected = "{name: 'mock', email: 'mock@email.com', html: 0, css: 0, javaScript: 0, python:0, django: 0, ios:0, android: 0}"
        
        let candidate = Candidate()
        candidate.name = "mock"
        candidate.email = "mock@email.com"
        candidate.html = 0
        candidate.css = 0
        candidate.javaScript = 0
        candidate.python = 0
        candidate.django = 0
        candidate.ios = 0
        candidate.android = 0
        
        XCTAssertNotNil(candidate.toJsonString(), "")
        XCTAssertEqual(candidate.toJsonString()!, expected, "")
    }
    
    func testCandidateToJosn() {
        let json = "{name: 'mock', email: 'mock@email.com', html: 0, css: 0, javaScript: 0, python:0, django: 0, ios:0, android: 0}"
        let expected = json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        let candidate = Candidate()
        candidate.name = "mock"
        candidate.email = "mock@email.com"
        candidate.html = 0
        candidate.css = 0
        candidate.javaScript = 0
        candidate.python = 0
        candidate.django = 0
        candidate.ios = 0
        candidate.android = 0
        
        XCTAssertNotNil(candidate.toJson(), "")
        XCTAssertEqual(candidate.toJson()!, expected!, "")
    }
}