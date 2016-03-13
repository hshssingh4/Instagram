//
//  User.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/12/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse

class User: NSObject
{
    var firstName: String?
    var lastName: String?
    var profileImageUrl: NSURL?
    var coverImageUrl: NSURL?
    var currentUser: PFUser?
    var posts: [Post]?
    
    init(user: PFUser)
    {
        super.init()
        self.firstName = user["firstName"] as? String
        self.lastName = user["lastName"] as? String
        if let imageFile = user.objectForKey("profileImage") as? PFFile
        {
            self.profileImageUrl = NSURL(string: imageFile.url!)
        }
        if let imageFile = user.objectForKey("coverImage") as? PFFile
        {
            self.coverImageUrl = NSURL(string: imageFile.url!)
        }
        currentUser = user
        initializePosts(user)
    }
    
    func initializePosts(user: PFUser)
    {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.whereKey("author", equalTo: currentUser!)
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
            }
            else
            {
                print(error?.localizedDescription)
            }
        }
    }
}
