//
//  EIRCityPicker.swift
//  EIRMatch
//
//  Created by William Tachau on 7/22/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRCityPicker : UITableViewController {
    
    // datasource and delegate
    var cityPickerHelper : EIRCityPickerTableViewHelper?
    
    // Information about the implementation
    let cellHeight = CGFloat(36.0)
    let cities = [City.NewYork, City.SanFrancisco, City.LosAngeles, City.Sunnyvale, City.LasVegas, City.OrangeCounty]

    var totalHeight : CGFloat?

    var chosenCity = "which office do you work in?"
    var city : City?
    
    override func viewDidLoad()  {
        // set up helper
        cityPickerHelper = EIRCityPickerTableViewHelper(cityPicker: self)
        if let helper = cityPickerHelper {
            helper.setReturn(popView)
            tableView.delegate = helper
            tableView.dataSource = helper
        }
        
        tableView.backgroundColor = backgroundColor
        navigationItem.hidesBackButton = true
        totalHeight = tableView.bounds.size.height + navBarHeight
    }
    
    // Set return function for the CityPicker controller
    func popView() -> () {
        self.navigationController.popViewControllerAnimated(true)
    }
}
