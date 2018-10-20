//
//  HomeViewController.swift
//  instragram
//
//  Created by Felipe De La Torre on 10/16/18.
//  Copyright © 2018 Felipe De La Torre. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var refreshControl: UIRefreshControl!
    var posts: [Post] = []
    
    
    @IBOutlet weak var postsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //needed for pull to refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        postsTableView.insertSubview(refreshControl, at: 0)
        
        
        postsTableView.delegate = self as! UITableViewDelegate
        postsTableView.dataSource = self as! UITableViewDataSource
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 200
    
       
        fetchPosts()
        postsTableView.reloadData()
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    //used when user pulls to refresh
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        
        fetchPosts()
        
    }
    
    //get post info
    @objc func fetchPosts() {
        
        
        // construct query
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.includeKey("createdAt")
        query?.limit = 20
        
        query?.findObjectsInBackground(block: { (posts, error) in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.postsTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            else {
                print(error.debugDescription)
            }
        })
    }
    
    //delegate protocol 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.indexPath = indexPath
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    cell.postImageView.image = UIImage(data: data!)
                }
            }
        }
        cell.postCommentLabel.text = post.caption
        return cell
    }
    
    //action for logout button
    @IBAction func onLogout(_ sender: Any) {
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    // action for camera button
    @IBAction func onCompose(_ sender: Any) {
        self.performSegue(withIdentifier: "composeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailedViewController = segue.destination as? DetailedViewController
        if let cell = sender as! PostCell? {
            detailedViewController?.post = posts[(cell.indexPath?.row)!]
        }
    }
    
}
