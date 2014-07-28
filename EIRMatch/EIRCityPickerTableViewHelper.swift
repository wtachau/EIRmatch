//
//  EIRCityPickerTableViewHelper.swift
//  EIRMatch
//
//  Created by William Tachau on 7/22/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRCityPickerTableViewHelper : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // The model
    var cityPicker : EIRCityPicker?
    
    init(cityPicker : EIRCityPicker) {
        self.cityPicker = cityPicker
    }
    
    // Number of rows
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return cityPicker!.cities.count
    }
    
    // Number of sections
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    // Height of header, adjusted
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        let totalh = (cityPicker!.totalHeight! - CGFloat(cityPicker!.cities.count) * cityPicker!.cellHeight)
        let totaldiv2 = totalh / 2.0
        let diff = (1.5 * navBarHeight)
        return totaldiv2 - diff
    }
    
    // Height of footer, adjusted
    func tableView(tableView: UITableView!, heightForFooterInSection section: Int) -> CGFloat {
        return (cityPicker!.totalHeight! - CGFloat(cityPicker!.cities.count) * cityPicker!.cellHeight) / CGFloat(2.0) - navBarHeight/2.0
    }
    
    // Height of each row
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return cityPicker!.cellHeight
    }
    
    // Each cell customized
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell : UITableViewCell?
        
        //variable type is inferred
        cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        
        if !cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        cell!.backgroundColor = buttonColor
        cell!.textLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        cell!.textLabel.text = cityPicker!.cities[indexPath.row].string()
        cell!.textLabel.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    // Set background color
    func tableView(tableView: UITableView!, willDisplayHeaderView view: UIView!, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = backgroundColor
        }
    }
    
    func tableView(tableView: UITableView!, willDisplayFooterView view: UIView!, forSection section: Int) {
        if let footer = view as? UITableViewHeaderFooterView {
            footer.contentView.backgroundColor = backgroundColor
        }
    }
    
    // City is selected
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        cityPicker!.chosenCity = cityPicker!.cities[indexPath.row].string()
        cityPicker!.city = cityPicker!.cities[indexPath.row]
        cityPicker!.navigationController.popViewControllerAnimated(true)
    }
    
}
