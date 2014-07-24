//
//  EIRPostLoader.swift
//  EIRMatch
//
//  Created by William Tachau on 7/24/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPostLoader : NSObject {
    
    func loadAllPosts(onFinish:((posts: [AnyObject]) -> ())) {
        
        var query = PFQuery(className: "Post")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error:NSError!) -> Void in
            
            if let e = error {
                println("ERROR loading posts: %@", e)
            } else {
                onFinish(posts: objects)
            }
        }
    }
}
