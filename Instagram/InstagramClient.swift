//
//  InstagramClient.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse
import UITextField_Shake

class InstagramClient: NSObject
{
    class func initializeParse()
    {
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "instagramios"
                configuration.clientKey = "khaj3wkqx3xhwnv4nv4uvqho3nrch9isad"
                configuration.server = "https://instagramios.herokuapp.com/parse"
            })
        )
    }
    
    class func signIn(username: String, password: String, vc: LoginViewController)
    {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil
            {
                print("you are logged in")
                NSNotificationCenter.defaultCenter().postNotificationName("Log In User", object: nil)
            }
            else
            {
                if error?.code == 101
                {
                    vc.usernameField.shake(10, withDelta: 5, speed: 0.03, shakeDirection: ShakeDirection.Vertical)
                    vc.passwordField.shake(10, withDelta: 5, speed: 0.03, shakeDirection: ShakeDirection.Vertical)
                }
                else if error?.code == 200
                {
                    vc.usernameField.shake(10, withDelta: 5, speed: 0.03, shakeDirection: ShakeDirection.Vertical)
                    vc.passwordField.shake(10, withDelta: 5, speed: 0.03, shakeDirection: ShakeDirection.Vertical)
                }
                else if error?.code == 201
                {
                    vc.passwordField.shake(10, withDelta: 5, speed: 0.03, shakeDirection: ShakeDirection.Vertical)
                }
            }
        }
    }
    
    class func signUp(firstName: String, lastName: String, username: String, password: String)
    {
        let newUser = PFUser()
        
        newUser.username = username
        newUser.password = password
        newUser["firstName"] = firstName
        newUser["lastName"] = lastName

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
    
    class func logout()
    {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName("Log Out User", object: nil)
    }
    
    class func addProfileImage(user: PFUser, image: UIImage)
    {
        user["profileImage"] = Post.getPFFileFromImage(image)
        user.saveInBackground()
    }
    
    class func addCoverImage(user: PFUser, image: UIImage)
    {
        user["coverImage"] = Post.getPFFileFromImage(image)
        user.saveInBackground()
    }
}
