//
//  EIRLogin.swift
//  EIRMatch
//
//  Created by William Tachau on 7/28/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRLoginController : UITableViewController {
    
    // datasource and delegate
    var loginHelper : EIRLoginHelper?
    
    // need to remember what's in these cells
    var nameField = UITextField()
    var passwordField = UITextField()
    var emailField = UITextField()
    var doneText = UILabel()
    var cityField = UILabel()
    
    // toggle signup or login
    var onSignup = true
    var numActiveCells = 4
    
    // to handle UI on login click
    let loginIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    var doneString = "done"
    
    // Changes dynamically
    var cityText = "which office are you in?"
    var cityTextChanged = false
    // VC to choose city
    var cityPicker = EIRCityPicker()
    
    // what to do after successful login
    var onSuccess: () -> () = {}
    
    override func viewDidLoad() {
        loginHelper = EIRLoginHelper(loginController: self)
        tableView.dataSource = loginHelper
        tableView.delegate = loginHelper
        tableView.backgroundColor = backgroundColor
        
        // get rid of separator color
        tableView.separatorColor = UIColor.clearColor()
    }
    
    // Refresh city text in case new city was chosen
    override func viewWillAppear(animated: Bool) {
        cityText = cityPicker.chosenCity
        tableView.reloadData()
    }
    
    // Save success function closure from app delegate
    func setLoginSuccess(function: (()->()))  {
        onSuccess = function
    }
    
    // Attempt logging in through Parse
    func tryLogin() {
        PFUser.logInWithUsernameInBackground(nameField.text, password: passwordField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            
            self.loginIndicator.stopAnimating()
            self.doneString = "done"
            if user {
                self.onSuccess()
            } else {
                let errorString = error.userInfo["error"] as NSString
                self.doneString = "done"
                self.tableView.reloadData()
                
                // Present alert
                let alert = UIAlertView(title: "Error", message: errorString.capitalizedString, delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
                
                // THIS WILL NEED TO BE IN IOS 8
//                var alert = UIAlertController(title: "Error", message: errorString.capitalizedString, preferredStyle: UIAlertControllerStyle.Alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Attempt signing up through Parse
    func trySignup() {
        var user = PFUser()
        user.username = nameField.text
        user.password = passwordField.text
        user.email = emailField.text
        
        // get city (city enum)
        user["city"] = {
            if let cityString = self.cityPicker.city {
                return cityString.toRaw()
            } else {
                return City.Other.toRaw()
            }
            }()
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            
            self.loginIndicator.stopAnimating()
            self.doneString = "done"
            if !error {
                self.onSuccess()
            } else {
                let errorString = error.userInfo["error"] as NSString
                self.doneString = "done"
                self.tableView.reloadData()
                
                // Present alert
                let alert = UIAlertView(title: "Error", message: errorString.capitalizedString, delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
                
//                FOR IOS 8
//                var alert = UIAlertController(title: "Error", message: errorString.capitalizedString, preferredStyle: UIAlertControllerStyle.Alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}