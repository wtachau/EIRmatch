//
//  EIRHomeMDCHelper.swift
//  EIRMatch
//
//  Created by William Tachau on 7/28/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

extension EIRHomeController {
    
    func viewDidCancelSwipe(view: UIView!) {
        //println("canceled swipe")
    }
    
    func view(view: UIView!, wasChosenWithDirection direction: MDCSwipeDirection) {
        if direction == MDCSwipeDirection.Left {
            //println("left!!!!!")
        } else {
            if let mdcView = view as? MDCSwipeToChooseView {
                
                let postViewer = EIRPostDetailViewer(post: allPosts[mdcView.tag])
                navigationController.pushViewController(postViewer, animated: true)
                
            }
        }
    }
    
    func setUpMDCViews() {
        
        mdcOptions.delegate = self;
        mdcOptions.likedColor = UIColor.clearColor()
        mdcOptions.nopeColor = UIColor.clearColor()
        
        //constants
        let buffer = CGFloat(20.0)
        let yOffset = CGFloat(50.0)
        let viewHeight = CGFloat(200.0)
        
        for (index, post) in enumerate(allPosts) {
            var mdcView = MDCSwipeToChooseView(frame: CGRectMake(buffer, yOffset,
            view.bounds.size.width - 2*buffer,
            viewHeight), options: mdcOptions)
            mdcView.backgroundColor = UIColor.blackColor()
            //mdcView.imageView.image = UIImage(named: "lightbulb.jpeg")
            
            // Get the name
            if let name = post.objectForKey("name") as? String {
            let nameText = UILabel(frame: CGRectMake(10,40,150,30))
            nameText.text = name
            nameText.textColor = UIColor.whiteColor()
            mdcView.addSubview(nameText)
            }
            
            // Get the city
            if let city = post.objectForKey("city") as? Int {
            let cityText = UILabel(frame:CGRectMake(10,60,150,30))
            cityText.text = City.fromRaw(city)!.string()
            cityText.textColor = UIColor.whiteColor()
            mdcView.addSubview(cityText)
            }
            
            // Add needs icons
            let spacing = CGFloat(10.0)
            var xOffset = spacing
            let iconSize = CGFloat(30.0)
            if let needs = post.objectForKey("needs") as? [String: String] {
                for (role, value) in needs {
                    if value == "1" {
                        var needsIcon = UIImageView(frame: CGRectMake(xOffset, 10, iconSize, iconSize))
                        needsIcon.image = Role.fromRaw(role.bridgeToObjectiveC().integerValue)!.image()
                        mdcView.addSubview(needsIcon)
                        xOffset += (iconSize + spacing)
                    }
                }
            }
            mdcView.tag = index
            view.addSubview(mdcView)
        }
    }
    
}