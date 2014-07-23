//
//  EIRPostHelper.swift
//  EIRMatch
//
//  Created by William Tachau on 7/23/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPostHelper : NSObject , UITableViewDataSource, UITableViewDelegate {
    
    var postController : EIRPostController?
    
    init(postController : EIRPostController) {
        
        self.postController = postController
        
    }
    
    // Number of rows per section
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 2
        }
    }
    
    // Number of sections
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 3
    }
    
    
    // Set background color
    func tableView(tableView: UITableView!, willDisplayHeaderView view: UIView!, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = backgroundColor
            header.textLabel.textColor = UIColor.whiteColor()
            header.textLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        }
    }
    
    // Set heights for each header
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    // Header titles
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        switch section {
        case 0:
            return "about you"
        case 1:
            return "what do you need?"
        default:
            return "about your project:"
        }
    }
    
    // Set height of cells
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let normal = Float(36)
        
        switch indexPath.section {
        case 0, 1:
            return normal
        default:
            if indexPath.row == 0 {
                return normal
            } else {
                return postController!.descHeight
            }
        }
    }
    
    
    // If office cell is selected
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if indexPath.section == 0 && indexPath.row == 1 {
            //todo separate into delegates
            postController!.navigationController.pushViewController(postController!.cityPicker, animated: true)
            postController!.cityTextChanged = true
        }
    }
    
    // Customize each cell
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var Cell : UITableViewCell?
        
        switch indexPath.section {
            
            // Name and Office
        case 0:
            Cell = postController!.setUpTopCell(indexPath)
            
            // What Do You Need?
        case 1:
            Cell = postController!.setUpMidCell(indexPath)
            
            // About your project
        default:
            Cell = postController!.setUpDescCell(indexPath)
            
        }
        Cell!.userInteractionEnabled = true
        return Cell
    }
}