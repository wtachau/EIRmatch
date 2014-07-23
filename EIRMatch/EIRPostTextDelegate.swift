//
//  EIRPostTextDelegate.swift
//  EIRMatch
//
//  Created by William Tachau on 7/22/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

// obsolete -- text field is now uitextview which doesn't need this delegate

/*
import UIKit

class EIRPostTextDelegate : NSObject, UITextViewDelegate {
    
    var postController : EIRPostController?
    
    init(postController : EIRPostController) {
        self.postController = postController
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        postController!.view.endEditing(true)
        postController!.postProject(self)
        return true
    }
    
}
*/