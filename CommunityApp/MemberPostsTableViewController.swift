//
//  MemberPostsTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/17/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class MemberPostsTableViewController: UITableViewController {

    var member: Member!
    var posts: [Post] = []
    var memberPosts: [Post] = []
    var postsStore: PostsStore = PostsStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        postsStore.fetchPosts { (PostsResult) -> Void in
            switch PostsResult {
            case let .success(posts):
                print("Successfully found \(posts.count)")
                OperationQueue.main.addOperation {
                    self.posts = posts
                    
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print("Error fetching posts: \(error)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberPosts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberPostCell", for: indexPath) as! MemberPostCell
        let memberPost = memberPosts[indexPath.row]
        cell.titleLabel.text = memberPost.title
        cell.memberLabel.text = "\(memberPost.member["firstName"]!) \(memberPost.member["lastName"]!)"
        cell.bodyLabel.text = memberPost.body
        return cell
    }
    

 
}
