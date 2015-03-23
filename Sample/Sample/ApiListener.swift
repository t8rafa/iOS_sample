//
//  ApiListener.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 21/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation

public protocol ApiListener {
    func onSuccess(response: Response)
    func onError(response: Response)
}