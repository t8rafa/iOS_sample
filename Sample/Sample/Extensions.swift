//
//  Extensions.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 21/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation


public extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        if let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex) {
            return predicate.evaluateWithObject(self)
        }
        
        return false
    }
}