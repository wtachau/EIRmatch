//
//  EIRPersonDetails.swift
//  EIRMatch
//
//  Created by William Tachau on 7/28/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPersonDetailsController: ViewController {
    
    var testLabel = UILabel()
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.blackColor()
        
        testLabel.frame = CGRectMake(0, 50, view.bounds.size.width, 30)
        if let name = appDelegate.currentUser?.username {
            testLabel.text = "\(name)"
        }
        testLabel.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        testLabel.textColor = UIColor.whiteColor()
        testLabel.textAlignment = NSTextAlignment.Center
        
        view.addSubview(testLabel)
    }
    
}
