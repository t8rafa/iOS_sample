//
//  ViewController.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 20/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import UIKit

class IntroductionController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("introduction_title", comment: "Title")
        titleLabel.text = NSLocalizedString("introduction_header", comment: "Header")
        explanationLabel.text = NSLocalizedString("introduction_text", comment: "Text")
        startButton.setTitle(NSLocalizedString("introduction_button", comment: "Button"), forState: .Normal)
    }
}