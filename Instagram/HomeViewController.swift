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
        //let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("TableViewHeaderView")! as UITableViewHeaderFooterView
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        
        let usernameLabel = UILabel(frame: CGRect(x: 8, y: 0, width: tableView.frame.size.width/2, height: 30))
        usernameLabel.text = posts![section].username!
        usernameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        let timestampLabel = UILabel(frame: CGRect(x: tableView.frame.size.width - 100, y: 0, width: 100, height: 30))
        timestampLabel.text = posts![section].timestamp!
        
        view.addSubview(usernameLabel)
        view.addSubview(timestampLabel)
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 30
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
