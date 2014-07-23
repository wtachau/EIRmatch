//
//  EIRResultsController.swift
//  EIRMatch
//
//  Created by William Tachau on 7/21/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRResultsController : UITableViewController, UITableViewDelegate, UITableViewDataSource {
   
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = backgroundColor
    }
}

extension EIRResultsController {
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell : UITableViewCell?
        
        //variable type is inferred
        cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        
        if !cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        //we know that cell is not empty now so we use ! to force unwrapping
        
        cell!.backgroundColor = backgroundColor
        
        return cell
    }
}
