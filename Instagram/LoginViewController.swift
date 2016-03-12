//
//  LoginViewController.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController
{
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSignIn(sender: AnyObject)
    {
        InstagramClient.signIn(usernameField.text!, password: passwordField.text!)
    }

    @IBAction func onSignUp(sender: AnyObject)
    {
        InstagramClient.signUp(usernameField.text!, password: passwordField.text!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
