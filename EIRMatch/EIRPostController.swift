//
//  EIRPostController.swift
//  EIRMatch
//
//  Created by William Tachau on 7/22/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPostController : UITableViewController {
    
    
    
    // Used because height of description changes dynamically based on screen size
    var descHeight : Float = 0.0
    
    // City name class and delegate
    var cityPicker : EIRCityPicker?
    var cityPickerHelper : EIRCityPickerTableViewHelper?
    
    // Also changes dynamically (todo: will be part of tableview datasource)
    var cityText = "which office are you in?"
    var cityTextChanged = false
    
    let sideBuffer = Float(10)
    let topBuffer = Float(9)

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        println("done")
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}










