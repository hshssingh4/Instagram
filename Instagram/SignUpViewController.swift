//
//  SignUpViewController.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/12/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import ChameleonFramework
import IHKeyboardAvoiding

class SignUpViewController: UIViewController
{
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let color1 = UIColor(hexString: "#218EBF", withAlpha: 0.9)
    let color2 = UIColor(hexString: "#215BA0")

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, self.firstNameField.frame.height))
        firstNameField.leftView = paddingView
        firstNameField.leftViewMode = UITextFieldViewMode.Always
        
        let paddingView2 = UIView(frame: CGRectMake(0, 0, 15, self.lastNameField.frame.height))
        lastNameField.leftView = paddingView2
        lastNameField.leftViewMode = UITextFieldViewMode.Always
        
        let paddingView3 = UIView(frame: CGRectMake(0, 0, 15, self.usernameField.frame.height))
        usernameField.leftView = paddingView3
        usernameField.leftViewMode = UITextFieldViewMode.Always
        
        let paddingView4 = UIView(frame: CGRectMake(0, 0, 15, self.passwordField.frame.height))
        passwordField.leftView = paddingView4
        passwordField.leftViewMode = UITextFieldViewMode.Always
        
        firstNameField.layer.cornerRadius = 5
        firstNameField.clipsToBounds = true
        lastNameField.layer.cornerRadius = 5
        lastNameField.clipsToBounds = true
        usernameField.layer.cornerRadius = 5
        usernameField.clipsToBounds = true
        passwordField.layer.cornerRadius = 5
        passwordField.clipsToBounds = true
        
        let backgroundColor = GradientColor(UIGradientStyle.TopToBottom, frame: self.view.frame, colors: [color1, color2])
        self.view.backgroundColor = backgroundColor
        
        IHKeyboardAvoiding.setAvoidingView(firstNameField)
        IHKeyboardAvoiding.setAvoidingView(lastNameField)
        IHKeyboardAvoiding.setAvoidingView(usernameField)
        IHKeyboardAvoiding.setAvoidingView(passwordField)
        IHKeyboardAvoiding.setPaddingForCurrentAvoidingView(5)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSignUpButton(sender: AnyObject)
    {
        if (firstNameField.text! != "" && lastNameField.text! != "" && usernameField.text! != "" && passwordField.text! != "")
        {
            InstagramClient.signUp(firstNameField.text!, lastName: lastNameField.text!, username: usernameField.text!, password: passwordField.text!)
            dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Make sure the fields are not empty!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onTapGesture(sender: AnyObject)
    {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func onSwipeGesture(sender: AnyObject)
    {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
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
