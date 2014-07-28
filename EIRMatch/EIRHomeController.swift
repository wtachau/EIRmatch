//
//  EIRHomeController.swift
//  EIRMatch
//
//  Created by William Tachau on 7/21/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRHomeController : ViewController, MDCSwipeToChooseDelegate {
    
    var BrowseButton : UIButton?
    var PostButton : UIButton?
    var SeeAllButton : UIButton?
    
    // Store all the posts, to be used in showing views
    var allPosts = Array<PFObject>()
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
        
        // Initialize buttons
        let buttonWidth = CGFloat(80)
        let buttonHeight = CGFloat(40)
        
        BrowseButton = UIButton(frame: CGRectMake((view.bounds.width - buttonWidth)/4,
                                                    0.55 * self.view.bounds.height,
                                                    buttonWidth, buttonHeight))
        PostButton = UIButton(frame: CGRectMake(3*(view.bounds.width - buttonWidth)/4,
            0.55 * self.view.bounds.height,
            buttonWidth, buttonHeight))
        
        SeeAllButton = UIButton(frame: CGRectMake((view.bounds.width - buttonWidth)/2,
            0.70 * self.view.bounds.height,
            buttonWidth, buttonHeight))
        
        
        if let button = SeeAllButton {
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            var title : String?
            title = "show all"
            button.addTarget(self, action: "showAllTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setTitle(title!, forState: UIControlState.Normal)
            button.titleLabel.textColor = UIColor.whiteColor()
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.whiteColor().CGColor
            view.addSubview(button)
        }
        
        
        // Loop through buttons to customize
//        var AllButtons = [BrowseButton, PostButton, SeeAllButton]
//        for (Index, Button) in enumerate(AllButtons) {
//            if let button = Button {
//                button.layer.cornerRadius = 10
//                button.layer.masksToBounds = true
//                var title : String?
//                switch Index {
//                    case 0:
//                        title = "browse"
//                        button.addTarget(self, action: "browseTapped:", forControlEvents: UIControlEvents.TouchUpInside)
//                    case 1:
//                        title = "post"
//                        button.addTarget(self, action: "postTapped:", forControlEvents: UIControlEvents.TouchUpInside)
//                    default:
//                        title = "show all"
//                        button.addTarget(self, action: "showAllTapped:", forControlEvents: UIControlEvents.TouchUpInside)
//                }
//                button.setTitle(title!, forState: UIControlState.Normal)
//                button.titleLabel.textColor = UIColor.whiteColor()
//                button.layer.borderWidth = 2
//                button.layer.borderColor = UIColor.whiteColor().CGColor
//                view.addSubview(button)
//            }
//        }
    }
    
    // Update datasource with new posts, and reload UITableView
    func setAllPosts(posts: [AnyObject]) -> () {
        allPosts = []
        for object in posts {
            if let post = object as? PFObject {
                allPosts.append(post)
            }
        }
        refresher.stopAnimating()
        
        // set up mdc views
        setUpMDCViews()
    }
}


extension EIRHomeController {
    
    // If browse button tapped, push Browse view controller
//    func browseTapped(AnyObject) {
//        navigationController.pushViewController(appDelegate.browseController, animated: true)
//    }

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
