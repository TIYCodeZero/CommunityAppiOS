//
//  CommunityAPI.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/09/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation


struct CommunityAPI {
    
    static let base: URL = URL(string: "http://codezerocommunity.herokuapp.com")!
    
    static var sessionConfig: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        return config
    }
}

extension CommunityAPI {
    enum Method {
        case register
        case login
        case memberDirectory
        case postsList
        case createPost
        case eventList
        case organizationList
        case createEvent
                
        var pathComponent: String {
            switch self {
            case .register:
                return "/register.json"
            case .login:
                return "/login.json"
            case .memberDirectory:
                return "/memberList.json"
            case .postsList:
                return "/postsList.json"
            case .createPost:
                return "/createPost.json"
            case .eventList:
                return "/eventsList.json"
            case .organizationList:
                return "/organizationsList.json"
            case .createEvent:
                return "/createEvent.json"
            }
        }
        var url: URL {
            return base.appendingPathComponent(pathComponent)
        }
    }
}
