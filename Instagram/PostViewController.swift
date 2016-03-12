//
//  PostViewController.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var postButton: UIBarButtonItem!
    @IBOutlet weak var cancelPostButton: UIBarButtonItem!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        postButton.enabled = false
        cancelPostButton.enabled = false
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTapGesture(sender: AnyObject)
    {
        captionTextField.resignFirstResponder()
    }
    
    @IBAction func onBrowseButton(sender: AnyObject)
    {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func onCancelPostButton(sender: AnyObject)
    {
        postImageView.image = UIImage(named: "Placeholder")
        captionTextField.text = nil
        cancelPostButton.enabled = false
        postButton.enabled = false
    }
    
    @IBAction func onCaptureButton(sender: AnyObject)
    {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = resize(originalImage, newSize: originalImage.size)
            postImageView.image = editedImage
            
            print(originalImage)
            
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
