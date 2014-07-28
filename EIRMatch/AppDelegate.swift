//
//  AppDelegate.swift
//  EIRMatch
//
//  Created by William Tachau on 7/21/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    
    // The current user
    var currentUser : PFUser?
    
    // set up relevant view controllers
    var navigationController: UINavigationController?
    var homeController : EIRHomeController?
    
    var detailsController : EIRPersonDetailsController?
    var postController : EIRPostController?
    var showAllController : EIRShowAllController?

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        
        //set up Parse
        Parse.setApplicationId("wb6OU1sqWT9vq78k7Pr2AW60ziY2IaUkg4aoJrwe", clientKey: "Dxa09Mny6GHFrcHEyFKqqswd0lCJwvhf5E8IXKUM")
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)

        // Init view controllers
        homeController = EIRHomeController()
        
        
        detailsController = EIRPersonDetailsController()
        postController = EIRPostController()
        showAllController = EIRShowAllController()
        
        myMethod()
        
        return true
        
    }
    
    
    // TODO: Remove
    func myMethod() {
        var user = PFUser()
        user.username = "Will Tachau"
        user.password = "myPassword"
        user.email = "email@example.com"
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if !error {
                println("login success")
                
                self.currentUser = user
                
                self.navigationController = UINavigationController(rootViewController: self.homeController)
                if let navBar = self.navigationController?.navigationBar {
                    navBar.barTintColor = backgroundColor
                    navBar.translucent = false
                    navBar.tintColor = UIColor.whiteColor()
                    navBar.titleTextAttributes = NSDictionary(dictionary: [UIColor.whiteColor():NSForegroundColorAttributeName])
                }
                
                self.window!.rootViewController = self.navigationController
            } else {
                let errorString = error.userInfo["error"] as NSString
                // Show the errorString somewhere and let the user try again.
            }
        }
    }

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
