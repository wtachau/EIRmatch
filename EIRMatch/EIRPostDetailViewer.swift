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

    var currentPost : EIRPost?
    
    let mailerDelegate = EIRMessageDelegate()
    
    init(post: EIRPost) {
        currentPost = post
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        // Set up text
        setUpText()
        
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
