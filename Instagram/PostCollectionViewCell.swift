//
//  PostCollectionViewCell.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/13/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var postImageView: UIImageView!
    
    var post: Post!
    {
        didSet
        {
            postImageView.clipsToBounds = true
            postImageView.setImageWithURL(post.mediaUrl!)
        }
    }
}
