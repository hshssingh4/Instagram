//
//  PostViewController.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import SVProgressHUD

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var postButton: UIBarButtonItem!
    @IBOutlet weak var cancelPostButton: UIBarButtonItem!
    let postImageTapGestureRecogonizer = UITapGestureRecognizer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        postButton.enabled = false
        cancelPostButton.enabled = false
        postImageTapGestureRecogonizer.addTarget(self, action: "promptToChoosePicture:")
        postImageView.addGestureRecognizer(postImageTapGestureRecogonizer)
        postImageView.userInteractionEnabled = true
    }
    
    func promptToChoosePicture(sender: UITapGestureRecognizer)
    {        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // Two Actions Added.
        alert.addAction(UIAlertAction(title: "Choose From Images", style: UIAlertActionStyle.Default, handler: choosePicture))
        alert.addAction(UIAlertAction(title: "Take A Picture", style: UIAlertActionStyle.Default, handler: takePicture))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // Present the Alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func choosePicture(alert: UIAlertAction)
    {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func takePicture(alert: UIAlertAction)
    {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTapGesture(sender: AnyObject)
    {
        captionTextField.resignFirstResponder()
    }

    @IBAction func onCancelPostButton(sender: AnyObject)
    {
        postImageView.image = UIImage(named: "Placeholder")
        captionTextField.text = nil
        cancelPostButton.enabled = false
        postButton.enabled = false
        captionTextField.resignFirstResponder()
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        postImageView.image = editedImage
        
        postButton.enabled = true
        cancelPostButton.enabled = true
            
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage
    {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func postImage(sender: AnyObject)
    {
        // Post the image to Parse
        SVProgressHUD.show()
        Post.postUserImage(resize(postImageView.image!, newSize: postImageView.image!.size), withCaption: captionTextField.text!) { (success: Bool, error: NSError?) -> Void in
            if success
            {
                SVProgressHUD.showSuccessWithStatus("Successfuly Posted!")
                self.postImageView.image = UIImage(named: "Placeholder")
                self.captionTextField.text = nil
                self.cancelPostButton.enabled = false
                self.postButton.enabled = false
                self.captionTextField.resignFirstResponder()
                let nc = self.tabBarController?.viewControllers![0] as! UINavigationController
                let vc = nc.topViewController as! HomeViewController
                vc.loadPosts()
                vc.tableView.reloadData()
                self.tabBarController?.selectedIndex = 0
            }
            else
            {
                SVProgressHUD.showErrorWithStatus("Error Occured!")
                print(error?.localizedDescription)
            }
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func onSwipeGesture(sender: AnyObject)
    {
        captionTextField.resignFirstResponder()
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
