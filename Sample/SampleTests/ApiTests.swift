//
//  ApiTests.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 22/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation
import XCTest
import Sample

class ApiTests: XCTestCase {
    class MockListener: ApiListener {
        var expectedResponse = Response()
        
        func onSuccess(response: Response) {
            validate(response)
        }
        
        func onError(response: Response) {
            validate(response)
        }
        
        private func validate(response: Response) {
            XCTAssertEqual(response.code, expectedResponse.code, "")
            XCTAssertEqual(response.status, expectedResponse.status, "")
            XCTAssertEqual(response.message, expectedResponse.message, "")
        }
    }
    
    class NoInternetConnectionMock: Connectable {
        func sendRequest(request: NSURLRequest, withCompletionHandler handler: (NSURLResponse!, NSData!, NSError!) -> Void) {
            let error = NSError(domain: "connection", code: -1000, userInfo: nil)
            handler(NSURLResponse(), NSData(), error)
        }
    }
    
    class InternetConnectionMock: Connectable {
        var code = 0
        var status = ""
        var message = ""
        
        func sendRequest(request: NSURLRequest, withCompletionHandler handler: (NSURLResponse!, NSData!, NSError!) -> Void) {
            let json = "{status: '\(status)', code: \(code), message: '\(message)'}";
            let data = json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            handler(NSURLResponse(), data, nil)
        }
    }
    
    func testNoInternetConnection() {
        let expected = Response()
        expected.code = -1000
        expected.status = "connection_error"
        expected.message = "The operation couldn’t be completed. (connection error -1000.)"
        
        let listener = MockListener()
        listener.expectedResponse = expected
        
        let connection = NoInternetConnectionMock()
        
        let candidate = Candidate()
        
        let api = Api(listener: listener, andConnection: connection);
        api.send(candidate)
    }
    
    func testInternetConnectionWithError() {
        let expected = Response()
        expected.code = 1
        expected.status = "error"
        expected.message = "Server mock error"
        
        let listener = MockListener()
        listener.expectedResponse = expected
        
        let connection = InternetConnectionMock()
        connection.code = 1
        connection.status = "error"
        connection.message = "Server mock error"
        
        let candidate = Candidate()
        
        let api = Api(listener: listener, andConnection: connection);
        api.send(candidate)
    }
    
    func testInternetConnectionWithSuccess() {
        let expected = Response()
        expected.code = 0
        expected.status = "success"
        expected.message = "Email sent"
        
        let listener = MockListener()
        listener.expectedResponse = expected
        
        let connection = InternetConnectionMock()
        connection.code = 0
        connection.status = "success"
        connection.message = "Email sent"
        
        let candidate = Candidate()
        
        let api = Api(listener: listener, andConnection: connection);
        api.send(candidate)
    }
}