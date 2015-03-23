//
//  FieldDescription.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 21/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation

class FieldDescription<T> {
    var title = ""
    var value: T?
    
    init(title: String, value: T?) {
        self.title = title
        self.value = value
    }
}