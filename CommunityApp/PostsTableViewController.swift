//
//  PostsTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/11/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {

    var posts: [Post] = []
    var postsStore: PostsStore = PostsStore()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Member Posts"
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
     }


}
