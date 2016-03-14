//
//  HomeViewController.swift
//  Instagram
//
//  Created by Harpreet Singh on 3/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var posts: [Post]?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "TableViewHeaderView")

        loadPosts()
        addRefreshControl()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func loadPosts()
    {
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
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
                self.tableView.reloadData()
            }
            else
            {
                print(error?.localizedDescription)
            }
        }
    }
    
    // Refresh control methods
    func addRefreshControl()
    {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.blackColor()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    func onRefresh()
    {
        loadPosts()
        self.refreshControl.endRefreshing()
    }
    
    // Table View Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        cell.post = posts![indexPath.section]
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
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
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let user = User(user: (posts![section].postObject!["author"] as! PFUser))
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("TableViewHeaderView")! as UITableViewHeaderFooterView
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        let userImageView = UIImageView(frame: CGRect(x: 8, y: 0, width: 50, height: 50))
        if let profileImageUrl = user.profileImageUrl
        {
            userImageView.setImageWithURL(profileImageUrl)
        }
        userImageView.layer.cornerRadius = 25
        userImageView.clipsToBounds = true
        
        let usernameLabel = UILabel(frame: CGRect(x: 70, y: 0, width: tableView.frame.size.width/2, height: 50))
        usernameLabel.text = posts![section].username!
        usernameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        let timestampLabel = UILabel(frame: CGRect(x: tableView.frame.size.width - 40, y: 0, width: 40, height: 50))
        timestampLabel.text = posts![section].timestamp!
        
        view.addSubview(userImageView)
        view.addSubview(usernameLabel)
        view.addSubview(timestampLabel)
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        headerView.addSubview(view)
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 50
    }
    
    // Deletion methods
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        let post  = posts![indexPath.section]
        if post.username == PFUser.currentUser()?.username
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.Delete)
        {
            let post = posts![indexPath.section]
            
            InstagramClient.deletePost(post, success: { (post: Post) -> () in
                self.posts?.removeAtIndex(indexPath.section)
                self.tableView.reloadData()
                }) { (error: NSError) -> () in
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let cell = sender as? UITableViewCell
        {
            let indexPath = tableView.indexPathForCell(cell)
            tableView.deselectRowAtIndexPath(indexPath!, animated: true)
            let selectedPost = posts![indexPath!.section]
            let pfUser = selectedPost.postObject!.objectForKey("author") as! PFUser
            let user = User(user: pfUser)
            let vc = segue.destinationViewController as! UserProfileViewController
            vc.user = user
        }
    }
}
