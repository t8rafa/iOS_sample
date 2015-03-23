//
//  Candidate.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 21/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation

public class Candidate : Serializable {
    public var name = ""
    public var email = ""
    public var html = 0
    public var css = 0
    public var javaScript = 0
    public var python = 0
    public var django = 0
    public var ios = 0
    public var android = 0
    
    public init() {
        
    }
    
    
    public func toJson() -> NSData? {
        let json = self.toJsonString()
        return json?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
    }
    
    public func toJsonString() -> String? {
        return "{name: '\(name)', email: '\(email)', html: \(html), css: \(css), javaScript: \(javaScript), python:\(python), django: \(django), ios:\(ios), android: \(android)}"
    }
}