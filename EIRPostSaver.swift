//
//  EIRPostSaver.swift
//  EIRMatch
//
//  Created by William Tachau on 7/23/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPostSaver : NSObject {

    func save (post: EIRPost) {
        
        var postObject = PFObject(className: "Post")
        postObject.setObject(post.name, forKey: "name")
        postObject.setObject(post.city!.toRaw(), forKey: "city")
        
        // Parse only likes NSDictionaries containing strings, so a little conversion is necessary
        var keyStrings = Array<String>()
        var objectStrings = Array<String>()
        for (key : Int, object : Bool) in post.needs {
            keyStrings.append(key.bridgeToObjectiveC().stringValue)
            objectStrings.append(object.bridgeToObjectiveC().stringValue)
        }
        var postDict = NSDictionary(objects: objectStrings, forKeys: keyStrings)
        
        postObject.setObject(postDict, forKey: "needs")
        postObject.setObject(post.title, forKey: "title")
        postObject.setObject(post.description, forKey: "description")
        postObject.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if !success {
                println("Error: \(error)")
            }
        }
    }
}