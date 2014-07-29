//
//  EIRHomeController.swift
//  EIRMatch
//
//  Created by William Tachau on 7/21/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRHomeController : ViewController, MDCSwipeToChooseDelegate {
    
    var SeeAllButton = UIButton()
    
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
        
        // Initialize see all button
        let buttonWidth = CGFloat(80)
        let buttonHeight = CGFloat(40)
        SeeAllButton.frame = CGRectMake((view.bounds.width - buttonWidth)/2,
                                        0.70 * self.view.bounds.height,
                                        buttonWidth, buttonHeight)
        SeeAllButton.layer.cornerRadius = 10
        SeeAllButton.layer.masksToBounds = true
        SeeAllButton.addTarget(self, action: "showAllTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        SeeAllButton.setTitle("show all", forState: UIControlState.Normal)
        SeeAllButton.titleLabel.textColor = UIColor.whiteColor()
        SeeAllButton.layer.borderWidth = 2
        SeeAllButton.layer.borderColor = UIColor.whiteColor().CGColor
        view.addSubview(SeeAllButton)
    }
    
    // Update datasource with new posts (func sent to postLoader)
    func setAllPosts(posts: [EIRPost]) -> () {
        allPosts = posts
        refresher.stopAnimating()
        
        // set up mdc views
        setUpMDCViews()
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
