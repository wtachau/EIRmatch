//
//  EIRPostController.swift
//  EIRMatch
//
//  Created by William Tachau on 7/22/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPostController : UITableViewController {
    
    // Datasource and delegate
    var postHelper : EIRPostHelper?
    
    var needs = Dictionary<Role, UISwitch>()
    var postTitle = UITextField()
    var postDesc = UITextView()
    
    // Used because height of description changes dynamically based on screen size
    var descHeight : CGFloat = 0.0
    
    let sideBuffer = CGFloat(10)
    let topBuffer = CGFloat(9)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up delegate/datasource
        postHelper = EIRPostHelper(postController: self)
        tableView.dataSource = postHelper!
        tableView.delegate = postHelper!
        
        needs[.Management] = UISwitch()
        needs[.Developer] = UISwitch()
        needs[.Design] = UISwitch()
        
        
        // format the bottom of the table
        tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
        tableView.backgroundColor = backgroundColor
        
        // to hide keyboard
//      let tap = UITapGestureRecognizer(target: self, action: "tableTapped:")
//        tableView.addGestureRecognizer(tap)
//        
        // calculate height so bottom cell fills screen
        self.descHeight = view.bounds.size.height
                        - tableView.rectForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)).origin.y
                        - navBarHeight
        
        // add "done" button to upper right
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                                            target: self, action: "postProject:")
    }
    
    // Hide keyboard when tapping outside text field
    func tableTapped(recognizer : UITapGestureRecognizer) {
     
        let tapLocation = recognizer.locationInView(tableView)
        let indexPath = tableView.indexPathForRowAtPoint(tapLocation)
        
        if !indexPath {
            view.endEditing(true)
        } else if (indexPath.row == 1 && indexPath.section == 2)
            || (indexPath.section == 0 && indexPath.row == 1) {
            recognizer.cancelsTouchesInView = false
        } else {
            view.endEditing(true)
        }
    }
    
    func postProject(AnyObject) {
        view.endEditing(true)
        
        // get needs (role enum: boolean)
        var needsDict = Dictionary<Int, Bool>()
        for (index, role) in enumerate([Role.Management, .Developer, .Design]) {
            needsDict[role.toRaw()] = needs[role]!.on
        }
        
        // Start saving process
        var postObject = PFObject(className: "Post")
        postObject.setObject(appDelegate.currentUser!, forKey: "userID")
        
        // Parse only likes NSDictionaries containing strings, so a little conversion is necessary
        var keyStrings = Array<String>()
        var objectStrings = Array<String>()
        for (key : Int, object : Bool) in needsDict {
            keyStrings.append(key.bridgeToObjectiveC().stringValue)
            objectStrings.append(object.bridgeToObjectiveC().stringValue)
        }
        var postDict = NSDictionary(objects: objectStrings, forKeys: keyStrings)
        
        postObject.setObject(postDict, forKey: "needs")
        postObject.setObject(postTitle.text, forKey: "title")
        postObject.setObject(postDesc.text, forKey: "description")
        postObject.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if !success {
                println("Error: \(error)")
            }
        }
        
        // Go back
        navigationController.popViewControllerAnimated(true)
    }
    
}










