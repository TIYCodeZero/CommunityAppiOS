//
//  OrganizationRequest.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/16/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

enum OrgResult {
    case success([Organization])
    case failure(String)
    
    init(data: Data) {
        guard ((try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]) != nil else {
            self = .failure("Unexpected data format in posts response")
            return
        }
        fatalError()
    }
}
