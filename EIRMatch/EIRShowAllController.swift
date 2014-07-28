//
//  EIRShowAllViewController.swift
//  EIRMatch
//
//  Created by William Tachau on 7/22/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRShowAllController: UITableViewController {
    
    let refresher = UIRefreshControl()
    
    var showAllHelper : EIRShowAllTableViewHelper?
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        // Set data source for the UITableView
        showAllHelper = EIRShowAllTableViewHelper()
        if let helper = showAllHelper {
            self.tableView.dataSource = helper
            self.tableView.delegate = helper
            helper.setReload(reload)
            helper.refreshPosts()
        }
        
        tableView.backgroundColor = backgroundColor
        refresher.tintColor = buttonColor
        refresher.addTarget(showAllHelper, action: "refreshPosts", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl = refresher
    }
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
    // Reload data on page, and tell UIRefresher to stop moving
    func reload() {
        self.tableView.reloadData()
        refresher.endRefreshing()
    }
    
}