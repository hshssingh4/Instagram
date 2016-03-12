//
//  Post.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject
{
    var username: String?
    var mediaUrl: NSURL?
    var datePosted: NSDate?
    var timestamp: String?
    
    init(post: PFObject)
    {
        username = (post.objectForKey("author") as! PFUser).username
        mediaUrl = NSURL(string: (post.objectForKey("media") as! PFFile).url!)
        print(post)
        let datePosted = post.createdAt
        if let datePosted = datePosted
        {
            let duration = (datePosted.timeIntervalSinceNow) * -1 // Get time passed.
            
            switch duration
            {
                case 0..<60:
                    timestamp = "\(Int(duration))s"
                case 60..<3600:
                    timestamp = "\(Int(duration / 60))m"
                case 3600..<86400:
                    timestamp = "\(Int(duration / 3600))h"
                default:
                    timestamp = "\(Int(duration / 86400))d"
            }
        }
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?)
    {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile?
    {
        // check if image is not nil
        if let image = image
        {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image)
            {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
