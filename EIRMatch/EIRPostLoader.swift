//
//  EIRPostLoader.swift
//  EIRMatch
//
//  Created by William Tachau on 7/24/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPostLoader : NSObject {
    
    // Loads posts from server, performs callback (closure)
    func loadAllPosts(onFinish:((posts: [EIRPost]) -> ())) {
        
        // generate query, perform asynchronously
        var query = PFQuery(className: "Post")
        query.includeKey("userID") //get user object too
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error:NSError!) -> Void in
            
            if let e = error {
                println("ERROR loading posts: %@", e)
            } else {
                
                // Generate array of EIRPost objects, iterate to fill
                var allPosts = Array<EIRPost>()
                for object in objects {
                    if let postObject = object as? PFObject {
                    
                        // grab the user object from query result
                        var user = postObject["userID"] as PFObject
                            
                        // turn string:string dict into int:bool
                        var needs = Dictionary<Int, Bool>()
                        if let needsDict = postObject["needs"] as? [String:String] {
                            for (key, value) in needsDict {
                                needs[key.bridgeToObjectiveC().integerValue] = (value == "1") ? true : false
                            }
                        }
                        // Now generate post
                        var post = EIRPost( username: user["username"] as NSString,
                                            userEmail: user["email"] as NSString,
                                            userID: user,
                                            needs: needs,
                                            title: postObject["title"] as NSString,
                                            description: postObject["description"] as NSString)
    
                        allPosts.append(post)
                    }
                    
                }
                // perform "callback" (closure)
                onFinish(posts: allPosts)
            }
        }
    }
}
