//
//  InstagramClient.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse

class InstagramClient: NSObject
{
    static func initializeParse()
    {
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "instagramios"
                configuration.clientKey = "khaj3wkqx3xhwnv4nv4uvqho3nrch9isad"
                configuration.server = "https://instagramios.herokuapp.com/parse"
            })
        )
    }
    
    static func signIn(username: String, password: String)
    {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil
            {
                print("you are logged in")
                NSNotificationCenter.defaultCenter().postNotificationName("Log In User", object: nil)
            }
        }
    }
    
    static func signUp(username: String, password: String)
    {
        let newUser = PFUser()
        
        newUser.username = username
        newUser.password = password

        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success
            {
                print("Created a user")
            }
            else
            {
                print(error?.localizedDescription)
                
                if error?.code == 202
                {
                    print("username is taken")
                }
            }
        }
    }
    
    static func logout()
    {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName("Log Out User", object: nil)
    }
}
