//
//  EIRBrowseTableViewHelper.swift
//  EIRMatch
//
//  Created by William Tachau on 7/22/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRShowAllTableViewHelper : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var allPosts = Array<PFObject>()
    // store reload function of the UITableView for which this is a datasource
    var reloadFunc: () -> () = {}
    
    // actual set the reload function
    func setReload(reload:(()->())) {
        self.reloadFunc = reload
    }
    
    // Tell PostLoader (server connection) to get all new posts
    func refreshPosts() {
        postLoader.loadAllPosts(setAllPosts)
    }
    
    // Update datasource with new posts, and reload UITableView
    func setAllPosts(posts: [AnyObject]) -> () {
        allPosts = []
        for object in posts {
            if let post = object as? PFObject {
                allPosts.append(post)
            }
        }
        reloadFunc()
    }
    
    
    // UITableViewDataSource functions
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return allPosts.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)

        if let nameText = allPosts[indexPath.row].objectForKey("name") as? String {
            cell.textLabel.text = nameText
            cell.textLabel.textColor = UIColor.whiteColor()
        }
        cell.backgroundColor = backgroundColor
        return cell
    }
    
    
    // If a project is selected
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        let postViewer = EIRPostDetailViewer(post: allPosts[indexPath.row])
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.navigationController!.pushViewController(postViewer, animated: true)
        
    }
}