//
//  UserProfileViewController.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse
import EXPhotoViewer

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var user: User?
    var posts: [Post]?
    var senderImageTag: Int?
    
    let profileImageTapGestureRecogonizer = UITapGestureRecognizer()
    let headerImageTapGestureRecogonizer = UITapGestureRecognizer()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        initializeView()
        collectionView.delegate = self
        collectionView.dataSource = self
        initializePosts()
        collectionView.reloadData()
        modifyView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func initializePosts()
    {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.whereKey("author", equalTo: user!.currentUser!)
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts
            {
                var newPosts = [Post]()
                for post in posts
                {
                    newPosts.append(Post(post: post))
                }
                self.posts = newPosts
                self.collectionView.reloadData()
            }
            else
            {
                print(error?.localizedDescription)
            }
        }
    }
    
    func initializeView()
    {
        nameLabel.text = "\(user!.firstName!) \(user!.lastName!)"
        usernameLabel.text = user!.currentUser!.username
        
        if let profileImageUrl = user!.profileImageUrl
        {
            profileImageView.setImageWithURL(profileImageUrl)
        }
        
        if let coverImageUrl = user!.coverImageUrl
        {
            headerImageView.setImageWithURL(coverImageUrl)
        }
        
        profileImageTapGestureRecogonizer.addTarget(self, action: "promptToChoosePicture:")
        headerImageTapGestureRecogonizer.addTarget(self, action: "promptToChoosePicture:")
        profileImageView.addGestureRecognizer(profileImageTapGestureRecogonizer)
        headerImageView.addGestureRecognizer(headerImageTapGestureRecogonizer)
    }
    
    func promptToChoosePicture(sender: UITapGestureRecognizer)
    {
        senderImageTag = sender.view!.tag
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // Two Actions Added.
        alert.addAction(UIAlertAction(title: "Choose Profile Picture", style: UIAlertActionStyle.Default, handler: choosePicture))
        alert.addAction(UIAlertAction(title: "Take Profile Picture", style: UIAlertActionStyle.Default, handler: takePicture))
        alert.addAction(UIAlertAction(title: "View This Photo", style: UIAlertActionStyle.Default, handler: showPicture))
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
    
    func showPicture(alert: UIAlertAction)
    {
        if senderImageTag == 10
        {
            EXPhotoViewer.showImageFrom(headerImageView)
        }
        else
        {
            EXPhotoViewer.showImageFrom(profileImageView)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        if senderImageTag == 10
        {
            headerImageView.image = editedImage
            InstagramClient.addCoverImage(user!.currentUser!, image: resize(headerImageView.image!, newSize: headerImageView.image!.size))

        }
        else
        {
            profileImageView.image = editedImage
            InstagramClient.addProfileImage(user!.currentUser!, image: resize(profileImageView.image!, newSize: profileImageView.image!.size))
        }
        
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
    
    
    // Collection View Methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if let posts = posts
        {
            return posts.count
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PostCollectionViewCell", forIndexPath: indexPath) as! PostCollectionViewCell
        cell.post = posts![indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let collectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) as! PostCollectionViewCell
        EXPhotoViewer.showImageFrom(collectionViewCell.postImageView)
    }
    
    //Modify View
    
    func modifyView()
    {
        profileImageView.layer.cornerRadius = 10.0
        profileImageView.clipsToBounds = true
        headerImageView.clipsToBounds = true
    }
    
    // Logout Methods
    
    @IBAction func onLogoutButton(sender: AnyObject)
    {
        let alert = UIAlertController(title: "Are you sure you want to log out?", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // Two Actions Added.
        alert.addAction(UIAlertAction(title: "Log Out", style: UIAlertActionStyle.Destructive, handler: logoutUser))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // Present the Alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func logoutUser(alert: UIAlertAction)
    {
        InstagramClient.logout()
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
