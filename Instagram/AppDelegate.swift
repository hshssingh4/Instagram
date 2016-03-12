//
//  AppDelegate.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeNavigationController = storyboard.instantiateViewControllerWithIdentifier("HomeNavigationController") as! UINavigationController
        homeNavigationController.tabBarItem.title = "Home Feed"
        homeNavigationController.tabBarItem.image = UIImage(named: "HomeIcon")
        
        let postNavigationController = storyboard.instantiateViewControllerWithIdentifier("PostNavigationController") as! UINavigationController
        postNavigationController.tabBarItem.title = "Post"
        postNavigationController.tabBarItem.image = UIImage(named: "PostIcon")
        
        let userProfileNavigationController = storyboard.instantiateViewControllerWithIdentifier("UserProfileNavigationController") as! UINavigationController
        userProfileNavigationController.tabBarItem.title = "Profile"
        userProfileNavigationController.tabBarItem.image = UIImage(named: "UserProfileIcon")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNavigationController, postNavigationController, userProfileNavigationController]
        
        // Initialize Parse
        InstagramClient.initializeParse()
        
        if PFUser.currentUser() != nil
        {
            print("There is a current user")
            
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName("Log Out User", object: nil, queue: NSOperationQueue.mainQueue()) { (NSNotification) -> Void in
            print("you are logged out")
            self.window?.rootViewController = storyboard.instantiateInitialViewController()
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName("Log In User", object: nil, queue: NSOperationQueue.mainQueue()) { (NSNotification) -> Void in
            print("you are logged in")
            self.window?.rootViewController = tabBarController
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

