//
//  EIRHomeController.swift
//  EIRMatch
//
//  Created by William Tachau on 7/21/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRHomeController : ViewController {
    
    var BrowseButton : UIButton?
    var PostButton : UIButton?
    var SeeAllButton : UIButton?
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = backgroundColor
        
        let buttonWidth = Float(80)
        let buttonHeight = Float(40)
        
        // Initialize buttons
        BrowseButton = UIButton(frame: CGRectMake((view.bounds.width - buttonWidth)/2,
                                                    0.15 * self.view.bounds.height,
                                                    buttonWidth, buttonHeight))
        PostButton = UIButton(frame: CGRectMake((view.bounds.width - buttonWidth)/2,
            0.35 * self.view.bounds.height,
            buttonWidth, buttonHeight))
        
        SeeAllButton = UIButton(frame: CGRectMake((view.bounds.width - buttonWidth)/2,
            0.55 * self.view.bounds.height,
            buttonWidth, buttonHeight))
        
        // Loop through buttons to customize
        var AllButtons = [BrowseButton, PostButton, SeeAllButton]
        for (Index, Button) in enumerate(AllButtons) {
            if let button = Button {
                button.layer.cornerRadius = 10
                button.layer.masksToBounds = true
                var title : String?
                switch Index {
                    case 0:
                        title = "browse"
                        button.addTarget(self, action: "browseTapped:", forControlEvents: UIControlEvents.TouchUpInside)
                    case 1:
                        title = "post"
                        button.addTarget(self, action: "postTapped:", forControlEvents: UIControlEvents.TouchUpInside)
                    default:
                        title = "show all"
                        button.addTarget(self, action: "showAllTapped:", forControlEvents: UIControlEvents.TouchUpInside)
                }
                button.setTitle(title!, forState: UIControlState.Normal)
                button.titleLabel.textColor = UIColor.whiteColor()
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.whiteColor().CGColor
                view.addSubview(button)
            }
        }
    }
    
}

extension EIRHomeController {
    
    // If browse button tapped, push Browse view controller
    func browseTapped(AnyObject) {
        navigationController.pushViewController(appDelegate.browseController, animated: true)
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
