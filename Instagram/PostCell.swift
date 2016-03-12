//
//  PostCell.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/12/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import AFNetworking
import Parse

class PostCell: UITableViewCell
{
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    
    
    var post: Post!
    {
        didSet
        {
            usernameLabel.text = post.username
            profileImageView.setImageWithURL(post.mediaUrl!)
            timestampLabel.text = post.timestamp!
        }
    }

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
