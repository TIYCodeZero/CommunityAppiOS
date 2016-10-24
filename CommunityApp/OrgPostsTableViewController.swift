//
//  OrgPostsTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/18/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class OrgPostsTableViewController: UITableViewController {
    
    var user: Member?
    var posts: [Post] = []
    var postsStore: PostsStore = PostsStore()
    var organization: Organization!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(organization.name) Posts"
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        getMemberPosts {
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

    func getMemberPosts(completionHandler: @escaping (PostsResult) -> Void) -> Void {
        let organization = self.organization!
        let name = organization.name
        let id = organization.id
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.postsByOrg
        var request = URLRequest(url: method.url)
        request.httpMethod = "POST"
        let orgPostProfile: [String: Any] = ["name": name, "id": id]
        request.httpBody = try! JSONSerialization.data(withJSONObject: orgPostProfile, options: [])
        let task = session.dataTask(with: request) { (optData, optResponse, optError) in
            guard let data = optData else {
                let errorDescription = optResponse?.description ?? optError!.localizedDescription
                let postsResult: PostsResult = .failure(errorDescription)
                completionHandler(postsResult)
                return
            }
            let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as [String: Any]
            let postDictionaries = jsonObject["postList"] as? [[String: Any]]
            let posts = Post.array(dictionaries: postDictionaries!)
            completionHandler(.success(posts))
        }
        task.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreatePost" {
            let createPostVC = segue.destination as! CreatePostViewController
            createPostVC.user = user
            createPostVC.organization = organization
        }
    }
    
}
