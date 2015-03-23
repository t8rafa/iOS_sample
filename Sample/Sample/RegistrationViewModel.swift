//
//  RegistrationViewModel.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 21/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation

class RegistrationViewModel {
    let numberOfSections = 2
    
    let candidateDataSource = [
        FieldDescription(title: "registration_name", value: ""),
        FieldDescription(title: "registration_email", value: "")
    ]
    
    let skillsDataSource = [
        FieldDescription(title: "HTML", value: 0),
        FieldDescription(title: "CSS", value: 0),
        FieldDescription(title: "Javascript", value: 0),
        FieldDescription(title: "Python", value: 0),
        FieldDescription(title: "Django", value: 0),
        FieldDescription(title: "iOS", value: 0),
        FieldDescription(title: "Android", value: 0)
    ]
}