//
//  EIRMessageDelegate.swift
//  EIRMatch
//
//  Created by William Tachau on 7/28/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import Foundation
import MessageUI

class EIRMessageDelegate: NSObject, MFMailComposeViewControllerDelegate {
    
    var parentClass : EIRPostDetailViewer?
    
    func setParent(parent : EIRPostDetailViewer) {
        self.parentClass = parent
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        // Apple's library still buggy
        
//        switch(result.value) {
//        case MFMailComposeResultCancelled:
//            "nothing"
//            //println("cancelled")
//        default:
//            "nothing"
//            //println("something else happened")
//        }

        // And dismiss view
        if let parent = parentClass {
            parent.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}
