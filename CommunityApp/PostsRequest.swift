//
//  PostsRequest.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/11/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

enum PostsResult {
    case success([Post])
    case failure(String)
    
    init(data: Data) {
        guard let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: AnyObject]] else {
            self = .failure("Your effort to get posts was unsuccessful")
            return
        }
        let posts = jsonObject.flatMap {
            (dictionary) in
            return Post(dictionary: dictionary)
        }
        guard posts.count == jsonObject.count else {
            self = .failure("A dictionary was dropped while fetching posts")
            return
        }
        self = .success(posts)
    }
}

func postsFromJSONData(_ data: Data)-> PostsResult {
    do {
        let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: [])
        guard let
            postsArray = jsonObject as? [[String: AnyObject]] else {
                return .failure("Cannot create array of posts from jsonObject")
        }
        var finalPosts = [Post]()
        for postJSON in postsArray {
            if let post = postFromJSONObject(postJSON){
                finalPosts.append(post)
            }
        }
        if finalPosts.count == 0 && !postsArray.isEmpty == false {
            return .failure("Could not create post from jsonObject")
        }
        return .success(finalPosts)
    }
    catch _ {
        return.failure("something went wrong getting posts from jsonData")
    }
}

fileprivate func postFromJSONObject(_ json: [String:Any])-> Post? {
    guard let
        date = json["date"] as? Date,
        let title = json["title"] as? String,
        let body = json["body"] as? String,
        let author = json["author"] as? Member else {
            return nil
    }
    let post = Post(date: date, title: title, body: body, author: author)
    return post
}




