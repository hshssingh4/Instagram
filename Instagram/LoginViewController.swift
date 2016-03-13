//
//  LoginViewController.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse
import ChameleonFramework
import IHKeyboardAvoiding


class LoginViewController: UIViewController
{
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var instagramIconImageView: UIImageView!
    
    let color1 = UIColor(hexString: "#218EBF", withAlpha: 0.9)
    let color2 = UIColor(hexString: "#215BA0")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 5
        signUpButton.clipsToBounds = true
        usernameField.layer.cornerRadius = 5
        usernameField.clipsToBounds = true
        passwordField.layer.cornerRadius = 5
        passwordField.clipsToBounds = true
        
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, self.usernameField.frame.height))
        usernameField.leftView = paddingView
        usernameField.leftViewMode = UITextFieldViewMode.Always
        
        let paddingView2 = UIView(frame: CGRectMake(0, 0, 15, self.passwordField.frame.height))
        passwordField.leftView = paddingView2
        passwordField.leftViewMode = UITextFieldViewMode.Always
        
        let backgroundColor = GradientColor(UIGradientStyle.TopToBottom, frame: self.view.frame, colors: [color1, color2])
        self.view.backgroundColor = backgroundColor
        
        IHKeyboardAvoiding.setAvoidingView(instagramIconImageView)
        IHKeyboardAvoiding.setAvoidingView(usernameField)
        IHKeyboardAvoiding.setAvoidingView(passwordField)
        IHKeyboardAvoiding.setAvoidingView(loginButton)
        IHKeyboardAvoiding.setAvoidingView(signUpButton)
        IHKeyboardAvoiding.setPaddingForCurrentAvoidingView(5)
        
    }
    
    @IBAction func onTapGesture(sender: AnyObject)
    {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func onSwipeGesture(sender: AnyObject)
    {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSignIn(sender: AnyObject)
    {
        InstagramClient.signIn(usernameField.text!, password: passwordField.text!, vc: self)
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
