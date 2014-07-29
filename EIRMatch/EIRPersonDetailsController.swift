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
    var logoutButton = UIButton()
    var onLogout: () -> () = {}
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.blackColor()
        
        // testing
        testLabel.frame = CGRectMake(0, 50, view.bounds.size.width, 30)
        testLabel.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        testLabel.textColor = UIColor.whiteColor()
        testLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(testLabel)
        
        formatLogout()
    }
    
    // Refresh name when view appears
    override func viewDidAppear(animated: Bool) {
        if let name = appDelegate.currentUser?.username {
            testLabel.text = "\(name)"
        }
    }
    
    // logout function gets set from app delegate
    func setUpLogout(function: (()->())) {
        onLogout = function
    }
    
    // Set up logout button
    func formatLogout() {
        let buttonWidth = CGFloat(80)
        let buttonHeight = CGFloat(40)
        
        logoutButton.frame = CGRectMake((view.bounds.width - buttonWidth)/2,
            0.60 * self.view.bounds.height,
            buttonWidth, buttonHeight)
        logoutButton.layer.cornerRadius = 10
        logoutButton.layer.masksToBounds = true
        logoutButton.addTarget(self, action: "logout:", forControlEvents: UIControlEvents.TouchUpInside)
        logoutButton.setTitle("log out", forState: UIControlState.Normal)
        logoutButton.titleLabel.textColor = UIColor.whiteColor()
        logoutButton.layer.borderWidth = 2
        logoutButton.layer.borderColor = UIColor.whiteColor().CGColor
        view.addSubview(logoutButton)
    }
    
    // Logout, and perform app delegate's logout function
    func logout(AnyObject) {
        testLabel.text = ""
        PFUser.logOut()
        onLogout()
    }
    
    
}
