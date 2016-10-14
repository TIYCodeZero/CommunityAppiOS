//
//  MemberRequest.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/11/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

enum MembersResult {
    case success([Member])
    case failure (String)
    
    init(data: Data){
        guard let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: AnyObject]] else {
            self = .failure("Your efforts were unsuccessful")
            return
        }
        let members = jsonObject.flatMap {
            (dictionary) in
            return Member(dictionary: dictionary)
        }
        guard members.count == jsonObject.count else {
            self = .failure("A dictionary was dropped")
            return
        }
        self = .success(members)
    }
}

