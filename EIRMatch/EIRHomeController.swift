//
//  EIRHomeController.swift
//  EIRMatch
//
//  Created by William Tachau on 7/21/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRHomeController : ViewController, MDCSwipeToChooseDelegate {
    
    var ShowAllButton = UIButton()
    
    // Store all the posts, to be used in showing views
    var allPosts = Array<EIRPost>()
    var swipeViews = Array<MDCSwipeToChooseView>()
    let mdcOptions = MDCSwipeToChooseViewOptions()
    
    // Refresher while posts load
    let refresher = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
    override func viewDidLoad() {
        
        // First get all the posts
        refresher.frame = CGRectMake((view.bounds.size.width - refresher.bounds.size.width)/2,
                                        100, refresher.bounds.size.width, refresher.bounds.size.height)
        view.addSubview(refresher)
        refresher.startAnimating()
        postLoader.loadAllPosts(setAllPosts)
        
        // Customize view and nav bar buttons
        view.backgroundColor = backgroundColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: "postTapped:")
        var personImage = UIImage(named: "user91.png")
        let imageSize = CGFloat(25.0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: RBResizeImage(personImage, CGSizeMake(imageSize, imageSize)), style: UIBarButtonItemStyle.Bordered, target: self, action: "detailsTapped:")
        navigationItem.title = ""
        
        // give details controller closure to refresh posts
        if let detailsController = appDelegate.detailsController {
            detailsController.setUpRefresh(refreshPosts)
        }
        
        formatShowAllButton()
    }
    
    // Refresh posts (when user clicks or posts run out)
    func refreshPosts() {
        // remove all mdcviews, if there are any
        for subview in view.subviews {
            if subview.isKindOfClass(MDCSwipeToChooseView) {
                subview.removeFromSuperview()
            }
        }
        
        refresher.startAnimating()
        postLoader.loadAllPosts(setAllPosts)
    }
    
    // Update datasource with new posts (func sent to postLoader)
    func setAllPosts(posts: [EIRPost]) -> () {
        allPosts = posts
        
        sortPosts()
        
        refresher.stopAnimating()
        
        // set up mdc views
        setUpMDCViews()
    }
    
    // Sort the posts according to the roles of the user (could be optimized?)
    func sortPosts() {
        
        var sortedPosts = Array<EIRPost>()
        var postsWithNumMatches = Array<(EIRPost, Int)>()
        
        // get dict of roles from user
        var userRoles = Dictionary<Role, Bool>()
        if let roles = PFUser.currentUser()["Roles"] as? [String:String] {
            for (roleString, boolString) in roles {
                userRoles[Role.fromRaw(roleString.bridgeToObjectiveC().integerValue)!] = (boolString == "1") ? true : false
            }
        }
        
        for currentPost in allPosts {
            // find # of matches with user needs
            var numMatches = 0
            for (role, need) in currentPost.needs {
                // if the post needs it and the user has it
                if userRoles[role]! && need {
                    numMatches++
                }
            }
            
            // put into correct place into tuple array
            var placed = false
            for (index, (post, num)) in enumerate(postsWithNumMatches) {
                if numMatches > num {
                    postsWithNumMatches.insert((currentPost, numMatches), atIndex: index)
                    placed = true
                    break
                }
            }
            if !placed {
                postsWithNumMatches.insert((currentPost, numMatches), atIndex: postsWithNumMatches.count)
            }
        }
        
        // get array from tuple array
        for (post, _) in postsWithNumMatches {
            sortedPosts.append(post)
        }
        
        allPosts = sortedPosts
    }

    // If person details button tapped, push view controller
    func detailsTapped(AnyObject) {
        navigationController.pushViewController(appDelegate.detailsController, animated: true)
    }
    
    // If post button tapped, push Post view controller
    func postTapped(AnyObject) {
        navigationController.pushViewController(appDelegate.postController, animated: true)
    }
    
    // If show all button tapped, push Show All view controller
    func showAllTapped(AnyObject) {
        navigationController.pushViewController(appDelegate.showAllController, animated: true)
    }
}
