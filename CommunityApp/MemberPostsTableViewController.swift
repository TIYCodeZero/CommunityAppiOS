//
//  MemberPostsTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/17/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class MemberPostsTableViewController: UITableViewController {

    var user: Member?
    var member: Member!
    var posts: [Post] = []
    var memberPost: [Post] = []
    var postsStore: PostsStore = PostsStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        getPostsByMember { (PostsResult) -> Void in
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
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberPostCell", for: indexPath) as! MemberPostCell
        let memberPost = posts[indexPath.row]
        cell.titleLabel.text = memberPost.title
        cell.memberLabel.text = "\(memberPost.member["firstName"]!) \(memberPost.member["lastName"]!)"
        cell.bodyLabel.text = memberPost.body
        return cell
    }
    
    func getPostsByMember(completionHandler: @escaping (PostsResult) -> Void) -> Void {
        let member = self.member!
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.postsByMember
        var  request = URLRequest(url: method.url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: member.jsonObject, options: [])
        let task = session.dataTask(with: request) { (optData, optResponse, optError) in
            guard let data = optData else {
                let errorDescription = optResponse?.description ?? optError!.localizedDescription
                let postsResult: PostsResult = .failure(errorDescription)
                completionHandler(postsResult)
                return
            }
            let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as [String: Any]
            let postDictionaries = jsonObject["postList"] as? [[String: Any]]
            if postDictionaries != nil {
            let posts = Post.array(dictionaries: postDictionaries!)
            completionHandler(.success(posts))
            } else if jsonObject["errorMessage"] != nil {
                let someString = jsonObject["errorMessage"] as? String
                if (someString?.hasPrefix("Post list was empty"))! {
                    let posts: [Post] = []
                    self.displayAlertMessage()
                    completionHandler(.success(posts))
                }
            }
        }
        task.resume()
    }
        func displayAlertMessage(){
            CommunityApp.displayAlertMessage(title: "Alert", message: "\(member!.firstName) \(member!.lastName) has no posts", from: self)
        }
 
}
