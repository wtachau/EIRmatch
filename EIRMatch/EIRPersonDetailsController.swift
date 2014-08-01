//
//  EIRPersonDetails.swift
//  EIRMatch
//
//  Created by William Tachau on 7/28/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPersonDetailsController: ViewController {
    
    var idLabel = UILabel()
    var logoutButton = UIButton()
    var buttonArray = [UIButton]()
    var onLogout: () -> () = {}
    var refresh: () -> () = {}
    
    override func viewDidLoad() {
        
        //initial formatting
        view.backgroundColor = UIColor.blackColor()
        //self.navigationItem.backBarButtonItem.title = "asdF"// = UIBarButtonItem(title: "asdf", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        let titleLabel = UILabel(frame: CGRect.zeroRect)
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.text = "about me"
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        navigationItem.titleView.sizeToFit()
        

        formatIDButtons()
        formatLogout()
    }
    
    // Refresh roles when view appears
    override func viewDidAppear(animated: Bool) {
        
        if let roles = PFUser.currentUser()["Roles"] as? [String:String]{
            for (roleString, boolString) in roles {
                if boolString == "1" {
                    buttonArray[roleString.bridgeToObjectiveC().integerValue].selectIt()
                } else {
                    buttonArray[roleString.bridgeToObjectiveC().integerValue].unselectIt()
                }
            }
        }
    }
    
    // logout function gets set from app delegate
    func setUpLogout(function: ( () -> () ) ) {
        onLogout = function
    }
    
    // home view controller will refresh its mdc views
    func setUpRefresh(function: ( () -> () ) ) {
        refresh = function
    }
    
    // Set up ID Buttons
    func formatIDButtons() {
        
        // first set up text
        idLabel.text = "I can help with..."
        idLabel.frame = CGRectMake(0, 50, view.bounds.size.width, 30)
        idLabel.font = UIFont(name: "HelveticaNeue-Light", size: 22.0)
        idLabel.textColor = UIColor.whiteColor()
        idLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(idLabel)
        
        // now set up buttons
        for i in 0..<3 {
            buttonArray.append(UIButton())
        }
        
        
        var buttonWidth = CGFloat(75.0)
        var padding = CGFloat(20.0)
        var xOffset = (view.bounds.size.width - 3*buttonWidth) / 2 - padding
        var yOffset = CGFloat(100.0)
        let imagePadding = CGFloat(10.0)
        
        for (index, button) in enumerate(buttonArray) {
            button.frame = CGRectMake(xOffset, yOffset, buttonWidth, buttonWidth)
            xOffset += (buttonWidth + padding)
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.imageEdgeInsets = UIEdgeInsets(top: imagePadding, left: imagePadding,
                                                    bottom: imagePadding, right: imagePadding)
            button.backgroundColor = buttonColor
            button.addTarget(self, action: "updateTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setImage(Role.fromRaw(index)!.image(), forState: UIControlState.Normal)
            
            // and the adjacent label
            let nameLabel = UILabel(frame: CGRect.zeroRect)
            nameLabel.textColor = UIColor.whiteColor()
            nameLabel.text = Role.fromRaw(index)!.idString()
            nameLabel.sizeToFit()
            nameLabel.frame.origin = CGPoint(x:button.frame.origin.x,
                                            y: (button.frame.origin.y + buttonWidth + 5.0))
            
            view.addSubview(nameLabel)
            view.addSubview(button)
        }
    }
    
    // When update is tapped
    func updateTapped(button : UIButton) {

        button.selected ? button.unselectIt() : button.selectIt()
        
        let yOffset = CGFloat(40.0)
        let buttonOffset = CGFloat(button.frame.origin.y + button.frame.size.height + yOffset)
        
        // Start indicator going
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        indicator.frame.origin = CGPointMake((view.bounds.size.width - indicator.frame.size.width)/2,
                                            buttonOffset)
        indicator.startAnimating()
        view.addSubview(indicator)
        // Generate String:String dict of user roles
        var roleDict = [String:String]()
        for (index, button) in enumerate(buttonArray) {
            roleDict[index.bridgeToObjectiveC().stringValue] = button.selected.bridgeToObjectiveC().stringValue
        }
        PFUser.currentUser()["Roles"] = roleDict
        PFUser.currentUser().saveInBackgroundWithBlock {
            (success:Bool, error:NSError!) in
            indicator.stopAnimating()
            
            let checkSize = CGFloat(20.0)
            let check = UIImageView(image: UIImage(named: "check.png"))
            check.frame = CGRectMake((self.view.bounds.size.width - checkSize) / 2, buttonOffset, checkSize, checkSize)
            self.view.addSubview(check)
            check.hidden = false
            check.alpha = 1.0
            UIView.animateWithDuration(0.5, delay: 0.5, options: nil,
                                        animations: {
                                            check.alpha = 0.0
                                        }, completion: {
                                            (finished:Bool) in
                                            check.hidden = true
                                        })
            // update mdc views from before
            self.refresh()
        }
    }
    
    // Set up logout button
    func formatLogout() {
        let buttonWidth = CGFloat(80)
        let buttonHeight = CGFloat(40)
        
        logoutButton.frame = CGRectMake((view.bounds.width - buttonWidth)/2,
            0.80 * self.view.bounds.height,
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
        idLabel.text = ""
        PFUser.logOut()
        onLogout()
    }
}


// Add functionality to UIButton
extension UIButton {
    
    func selectIt() {
        layer.borderWidth = 4
        layer.borderColor = UIColor.whiteColor().CGColor
        selected = true
    }
    
    func unselectIt() {
        layer.borderWidth = 0
        selected = false
    }
}
