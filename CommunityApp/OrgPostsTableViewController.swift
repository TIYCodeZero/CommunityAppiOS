//
//  OrgPostsTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/18/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class OrgPostsTableViewController: UITableViewController {
    
    var posts: [Post] = []
    var postsStore: PostsStore = PostsStore()
    var organization: Organization!
//    var orgPostsRequest: OrgPosts.Request? {
//        guard let organization = organization else {
//            return nil
//        }
//        return OrgPosts.Request (organization: organization)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Member Posts"
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        postsStore.getMemberPosts {
            (PostsResult) -> Void in
            switch PostsResult {
            case let .success(posts):
                print("Successfully found \(posts.count) posts.")
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
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrgPostsCell", for: indexPath) as! OrgPostsCell
        let post = posts[indexPath.row]
        cell.titleLabel.text = post.title
        cell.memberLabel.text = "\(post.member["firstName"]!) \(post.member["lastName"]!)"
        cell.bodyLabel.text = post.body
        return cell
    }



}
