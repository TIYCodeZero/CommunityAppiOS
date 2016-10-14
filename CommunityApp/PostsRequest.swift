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
    
    // data: [String: Any]
    init(data: Data) {
        guard ((try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]) != nil else {
            self = .failure("Unexpected data format in posts response")
            return
        }
     fatalError()
    }
}

enum CreatePostResult {
    case success([Post])
    case failure(String)
    
    init(data: Data) {
        fatalError()
    }
}




