//
//  PostsStore.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/11/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class PostsStore {
    
    var allPosts: [Post] = []
    
    func fetchPosts(completionHandler: @escaping (PostsResult) -> Void) -> Void {
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.postsList
        var request = URLRequest(url: method.url)
        
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (optData, optResponse, optError) in
            guard let data = optData else {
                let errorDescription = optResponse?.description ?? optError!.localizedDescription
                let postsResult: PostsResult = .failure(errorDescription)
                completionHandler(postsResult)
                return
            }
            completionHandler(PostsResult(data: data))
        }
        task.resume()
    }
}