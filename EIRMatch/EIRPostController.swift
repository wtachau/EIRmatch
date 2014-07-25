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
    
    // Info that will be used to generate post
    var nameField = UITextField()
    // Also changes dynamically
    var cityText = "which office are you in?"
    var cityTextChanged = false
    
    var needs = Dictionary<Role, UISwitch>()
    var postTitle = UITextField()
    var postDesc = UITextView()
    
    // Used because height of description changes dynamically based on screen size
    var descHeight : CGFloat = 0.0
    
    // City name class and delegate
    var cityPicker : EIRCityPicker?
    var cityPickerHelper : EIRCityPickerTableViewHelper?
    
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
        
        cityPicker = EIRCityPicker()
        cityPickerHelper = EIRCityPickerTableViewHelper(cityPicker: cityPicker!)
        
        // set up city picker classes
        cityPicker!.tableView.delegate = cityPickerHelper!
        cityPicker!.tableView.dataSource = cityPickerHelper!
        
        // format the bottom of the table
        tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
        tableView.backgroundColor = backgroundColor
        
        // to hide keyboard
        let tap = UITapGestureRecognizer(target: self, action: "tableTapped:")
        tableView.addGestureRecognizer(tap)
        
        // calculate height so bottom cell fills screen
        self.descHeight = view.bounds.size.height
                        - tableView.rectForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 2)).origin.y
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
    
    override func viewWillAppear(animated: Bool) {
        cityText = cityPicker!.chosenCity
        tableView.reloadData()
    }
    
    func postProject(AnyObject) {
        view.endEditing(true)
        
        // get city (city enum)
        var city : City = {
            if let cityString = self.cityPicker!.city {
                return cityString
            } else {
                return City.Other
            }
        }()
        
        // get needs (role enum: boolean)
        var needsDict = Dictionary<Int, Bool>()
        for (index, role) in enumerate([Role.Management, .Developer, .Design]) {
            needsDict[role.toRaw()] = needs[role]!.on
        }
        
        // Generate Post object
        let newPost = EIRPost(name: nameField.text, city: city, needs: needsDict, title: postTitle.text, description: postDesc.text)
        postSaver.save(newPost)
        
        // Go back
        navigationController.popViewControllerAnimated(true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}










