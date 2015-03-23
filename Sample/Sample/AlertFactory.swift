//
//  MyAlertFactory.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 21/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation
import UIKit

public class AlertFactory {
    
    public class func confirmationWithTitle(title: String?, message: String?, yesHandler: ((UIAlertAction!) -> Void)!) -> UIAlertController {
        let result = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let yes = UIAlertAction(title: NSLocalizedString("alert_yes", comment: "OK"), style: UIAlertActionStyle.Default, handler: yesHandler)
        let no = UIAlertAction(title: NSLocalizedString("alert_no", comment: "Cancel"), style: UIAlertActionStyle.Cancel, handler: nil)
        
        result.addAction(no)
        result.addAction(yes)
        
        return result
    }
}