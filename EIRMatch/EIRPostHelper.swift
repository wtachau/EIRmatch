//
//  EIRPostHelper.swift
//  EIRMatch
//
//  Created by William Tachau on 7/23/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPostHelper : NSObject , UITableViewDataSource, UITableViewDelegate {
    
    // Keep track of postController that this is helping
    var postController : EIRPostController?
    
    init(postController : EIRPostController) {
        
        self.postController = postController
        
    }
    
    // Number of rows per section
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 2
        }
    }
    
    // Number of sections
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 2
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
            return "who do you need?"
        default:
            return "about your project:"
        }
    }
    
    // Set height of cells
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let normal = CGFloat(36)
        
        switch indexPath.section {
        case 0:
            return normal
        default:
            if indexPath.row == 0 {
                return normal
            } else {
                return postController!.descHeight
            }
        }
    }
    
    // Customize each cell
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var Cell : UITableViewCell?
        
        switch indexPath.section {
            // What Do You Need?
        case 0:
            Cell = postController!.setUpMidCell(indexPath)
            // About your project
        default:
            Cell = postController!.setUpDescCell(indexPath)
        }
        Cell!.userInteractionEnabled = true
        return Cell
    }
}