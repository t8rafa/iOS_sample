//
//  Connectable.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 22/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation

public protocol Connectable {
    func sendRequest(request: NSURLRequest, withCompletionHandler handler: (NSURLResponse!, NSData!, NSError!)-> Void)
}