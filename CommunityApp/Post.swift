//
//  Post.swift
//  Community
//
//  Created by Dan Esrey on 2016/04/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

class Post {
    
    var date: Date
    var title: String
    var body: String
    var member: Member
    
    init(date: Date, title: String, body: String, member: Member) {
        self.date = date
        self.title = title
        self.body = body
        self.member = member
    }
    
    convenience init?(dictionary: [String: Any]){
        guard  let date = dictionary["date"] as? Date,
        let title = dictionary["title"] as? String,
        let body = dictionary["body"] as? String,
        let member = dictionary["member"] as? Member else {
            return nil
        }
        self.init(date: date, title: title, body: body, member: member)
    } 
}
