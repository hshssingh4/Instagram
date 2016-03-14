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
    }
}
