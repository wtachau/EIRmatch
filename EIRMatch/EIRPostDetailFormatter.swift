//
//  EIRPostDetailFormatter.swift
//  EIRMatch
//
//  Created by William Tachau on 7/30/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

extension EIRPostDetailViewer {
    
    func setUpText() {
        if let post = currentPost {
            var nameField = UILabel()
            var titleField = UILabel()
            var descField = UILabel()
            var emailButton = UIButton()
            var needsLabel = UILabel()
            
            // Get the title
            titleField.frame = CGRect.zeroRect
            titleField.frame.origin = CGPointMake(10,10)
            titleField.textColor = UIColor.whiteColor()
            titleField.text = post.title
            titleField.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
            titleField.sizeToFit()
            
            // Get the name
            nameField.frame = .zeroRect
            nameField.frame.origin = CGPointMake(10,50)
            nameField.text = post.username
            nameField.textColor = UIColor.whiteColor()
            nameField.sizeToFit()
            
            // Description
            let descBuffer = CGFloat(10.0)
            descField.frame = CGRectMake(10, 70, view.bounds.size.width - 2 * descBuffer, 100)
            descField.numberOfLines = 0
            descField.frame.origin = CGPointMake(10,70)
            descField.textColor = UIColor.whiteColor()
            descField.text = post.description
            descField.sizeToFit()
            
            // Needs
            needsLabel.frame = CGRect.zeroRect
            needsLabel.frame.origin = CGPointMake(10, descField.frame.maxY + 10)
            needsLabel.textColor = UIColor.whiteColor()
            needsLabel.text = "needs: "
            var prefix = ""
            for (role, need) in post.needs {
                if need {
                    needsLabel.text  = needsLabel.text + prefix + role.string()
                    prefix = ", "
                }
            }
            //needsLabel.text = post.needs[2]?.bridgeToObjectiveC().stringValue // [Role.Management.toRaw()]
            needsLabel.sizeToFit()
            
            // Set up email button
            let buttonSize = CGFloat(90.0)
            let yOffset = CGFloat(200.0)
            emailButton.frame = CGRectMake((view.bounds.size.width - buttonSize)/2,
                yOffset, buttonSize, buttonSize)
            emailButton.setImage(UIImage(named: "packet.png"), forState: UIControlState.Normal)
            emailButton.addTarget(self, action: "sendEmail", forControlEvents: UIControlEvents.TouchUpInside)
            
            // Add all views
            view.addSubview(emailButton)
            view.backgroundColor = backgroundColor
            view.addSubview(nameField)
            view.addSubview(titleField)
            view.addSubview(descField)
            view.addSubview(needsLabel)
        }
    }
}