//
//  EIRHomeMDCHelper.swift
//  EIRMatch
//
//  Created by William Tachau on 7/28/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

extension EIRHomeController {
    
    func view(view: UIView!, wasChosenWithDirection direction: MDCSwipeDirection) {
        if direction == MDCSwipeDirection.Right {
            if let mdcView = view as? MDCSwipeToChooseView {
                // Push post details view controller
                let postViewer = EIRPostDetailViewer(post: allPosts[mdcView.tag])
                navigationController.pushViewController(postViewer, animated: true)
            }
        }
    }
    
    func setUpMDCViews() {
        
        mdcOptions.delegate = self;
        // hide obnoxious text from library
        mdcOptions.likedColor = UIColor.clearColor()
        mdcOptions.nopeColor = UIColor.clearColor()
        
        //constants
        let buffer = CGFloat(20.0)
        let yOffset = CGFloat(50.0)
        let viewHeight = CGFloat(200.0)
        
        for (index, post) in enumerate(allPosts) {
            var mdcView = MDCSwipeToChooseView(
                                frame: CGRectMake(buffer,
                                                    yOffset,
                                                    view.bounds.size.width - 2*buffer,
                                                    viewHeight),
                                options: mdcOptions)
            mdcView.backgroundColor = UIColor.blackColor()
            //mdcView.imageView.image = UIImage(named: "lightbulb.jpeg")
            
            // Get the name
            let nameText = UILabel(frame: CGRectMake(10,40,150,30))
            nameText.text = post.username
            nameText.textColor = UIColor.whiteColor()
            mdcView.addSubview(nameText)
            
            // Get the city (from user)
            if let city = post.userID!.objectForKey("city") as? Int {
                let cityText = UILabel(frame:CGRectMake(10,60,150,30))
                cityText.text = City.fromRaw(city)!.string()
                cityText.textColor = UIColor.whiteColor()
                mdcView.addSubview(cityText)
            }
            
            // Add needs icons
            let spacing = CGFloat(10.0)
            var xOffset = spacing
            let iconSize = CGFloat(30.0)
            for (role, value) in post.needs {
                if value {
                    var needsIcon = UIImageView(frame: CGRectMake(xOffset, 10, iconSize, iconSize))
                    needsIcon.image = Role.fromRaw(role)!.image()
                    mdcView.addSubview(needsIcon)
                    xOffset += (iconSize + spacing)
                }
            }
            mdcView.tag = index
            view.addSubview(mdcView)
        }
    }
    
}