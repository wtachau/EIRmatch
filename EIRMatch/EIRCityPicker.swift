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
    let cities = [City.NewYork, City.SanFrancisco, City.LosAngeles, City.Sunnyvale, City.LasVegas, City.OrangeCounty]

    var totalHeight : Float?

    var chosenCity = "which office do you work in?"
    var city : City?
    
    override func viewDidLoad()  {
        tableView.backgroundColor = backgroundColor
        navigationItem.hidesBackButton = true
        totalHeight = tableView.bounds.size.height + navBarHeight
    }
}
