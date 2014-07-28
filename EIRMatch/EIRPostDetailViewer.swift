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
    
    let mailerDelegate = EIRMessageDelegate()
    
    
    init(post: PFObject) {
        // Get the name
        if let name = post.objectForKey("name") as? String {
            nameField.frame = CGRectMake(10,10,150,30)
            nameField.text = name
            nameField.textColor = UIColor.whiteColor()
        }
        
        // Get the city
        if let title = post.objectForKey("title") as? String {
            titleField.frame = CGRectMake(10,30,150,30)
            titleField.textColor = UIColor.whiteColor()
            titleField.text = title
        }
        
        // Description
        if let desc = post.objectForKey("description") as? String {
            descField.frame = CGRectMake(10,50, 250, 40)
            descField.textColor = UIColor.whiteColor()
            descField.text = desc
        }
        
        // Needs
        if let needs = post.objectForKey("needs") as? [String: String] {
            needsLabel.frame = CGRectMake(10, 70, 250, 40)
            needsLabel.textColor = UIColor.whiteColor()
            needsLabel.text = needs[Role.Management.toRaw().bridgeToObjectiveC().stringValue]
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        let buttonSize = CGFloat(90.0)
        let yOffset = CGFloat(200.0)
        emailButton.frame = CGRectMake((view.bounds.size.width - buttonSize)/2,
                                            yOffset, buttonSize, buttonSize)
        emailButton.setImage(UIImage(named: "packet.png"), forState: UIControlState.Normal)
        emailButton.addTarget(self, action: "sendEmail", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        view.addSubview(emailButton)
        view.backgroundColor = backgroundColor
        view.addSubview(nameField)
        view.addSubview(titleField)
        view.addSubview(descField)
        view.addSubview(needsLabel)
    }
    
    
    // Generate and present mail viewer
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailer = MFMailComposeViewController()
            mailerDelegate.setParent(self)
            mailer.mailComposeDelegate = mailerDelegate
            mailer.setSubject("test")
            mailer.setToRecipients(["test@example.com"])
            mailer.setMessageBody("hello", isHTML: false)
            self.presentViewController(mailer, animated: true, completion: nil)
        } else {
            println("ERROR: Unable to present MFMailComposeView")
        }
    }
    
}
