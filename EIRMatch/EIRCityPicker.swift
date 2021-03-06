//
//  EIRCityPicker.swift
//  EIRMatch
//
//  Created by William Tachau on 7/22/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRCityPicker : UITableViewController {
    
    // Information about the implementation
    let cellHeight = Float(36.0)
    let cities = ["New York", "San Francisco", "Los Angeles", "Sunnyvale", "Las Vegas", "Orange County"]
    
    var navBarHeight : Float?
    var totalHeight : Float?

    var chosenCity = "which office do you work in?"
    
    override func viewDidLoad()  {
        tableView.backgroundColor = backgroundColor
        navigationItem.hidesBackButton = true
        navBarHeight = Float(64)
        totalHeight = tableView.bounds.size.height + navBarHeight!
    }
}
