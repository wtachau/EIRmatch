//
//  EIRBrowseTableViewHelper.swift
//  EIRMatch
//
//  Created by William Tachau on 7/22/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRShowAllTableViewHelper : NSObject, UITableViewDataSource {
    
    
    init() {
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)

        cell.textLabel.text = "hello"
        return cell
    }
}