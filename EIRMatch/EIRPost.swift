//
//  EIRPostSaver.swift
//  EIRMatch
//
//  Created by William Tachau on 7/23/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPost {
    
    var username : String?
    var userEmail : String
    var userID : PFObject?
    var needs : Dictionary<Int, Bool>
    var title : String
    var description : String
    
    init(username: String, userEmail: String, userID: PFObject, needs: Dictionary<Int, Bool>, title: String, description: String) {
        
        self.username = username
        self.userEmail = userEmail
        self.userID = userID
        self.needs = needs
        self.title = title
        self.description = description
    }
}
