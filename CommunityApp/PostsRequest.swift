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
        guard let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]] else {
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

enum CreatePostResult {
    case success([Post])
    case failure(String)
    
    init(data: Data) {
        guard let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {
            self = .failure("Your effort to create a post was unsuccessful")
            return
        }
        guard let postsArray = jsonObject["postsList"] as? [[String: Any]] else {
            self = .failure("You received data but no posts list")
            return
        }
        let posts = postsArray.flatMap {
            (dictionary) in
            return Post(dictionary: dictionary)
        }
        guard posts.count == postsArray.count else {
            self = .failure("a dictionary was dropped from jsonObject")
            return
        }
        self = .success(posts)
    }    
    
}




