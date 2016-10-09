//
//  CommunityAPI.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/09/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation


struct CommunityAPI {
    
//  Change url placeholder
    static let base: URL = URL(string: "placeholder.com")!
    
    static var sessionConfig: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Accept": "application.json",
            "Content-Type": "application.json"
        ]
        return config
    }
    
}

extension CommunityAPI {
    enum Method {
        case register
        case login
        
// Confirm pathComponent
        
        var pathComponent: String {
            switch self {
            case .register:
                return "register.json"
            case .login:
                return "login.json"
            }
        }
        
        var url: URL {
            return base.appendingPathComponent(pathComponent)
        }
    }
}
