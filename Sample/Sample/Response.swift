//
//  Response.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 21/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation

public class Response {
    public var status: String
    public var code: Int
    public var message: String
    
    public init() {
        self.status = ""
        self.code = 0
        self.message = ""
    }
}