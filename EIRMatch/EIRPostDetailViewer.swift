//
//  EIRPostDetailViewer.swift
//  EIRMatch
//
//  Created by William Tachau on 7/25/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit
import MessageUI

class EIRPostDetailViewer : UIViewController {

    var nameField = UILabel()
    var titleField = UILabel()
    var descField = UILabel()
    var emailButton = UIButton()
    var needsLabel = UILabel()
    
    var currentPost : EIRPost?
    
    let mailerDelegate = EIRMessageDelegate()
    
    init(post: EIRPost) {
        currentPost = post
        
        // Get the name
        if let name = post.username {
            nameField.frame = CGRectMake(10,10,150,30)
            nameField.text = name
            nameField.textColor = UIColor.whiteColor()
        }
        
        // Get the title
        titleField.frame = CGRectMake(10,30,150,30)
        titleField.textColor = UIColor.whiteColor()
        titleField.text = post.title
        
        // Description
        descField.frame = CGRectMake(10,50, 250, 40)
        descField.textColor = UIColor.whiteColor()
        descField.text = post.description
        
        // Needs
        needsLabel.frame = CGRectMake(10, 70, 250, 40)
        needsLabel.textColor = UIColor.whiteColor()
        needsLabel.text = post.needs[2]?.bridgeToObjectiveC().stringValue // [Role.Management.toRaw()]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
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
    
    
    // Generate and present mail viewer
    func sendEmail() {
        
        if let post = currentPost {
            if MFMailComposeViewController.canSendMail() {
                let mailer = MFMailComposeViewController()
                mailerDelegate.setParent(self)
                mailer.mailComposeDelegate = mailerDelegate
                mailer.setSubject("Your Project: \(post.title)")
                mailer.setToRecipients(["\(post.userEmail)"])
                self.presentViewController(mailer, animated: true, completion: nil)
            } else {
                println("ERROR: Unable to present MFMailComposeView")
            }
        }
    }
    
}
