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
    var id: Int
    var member: [String: Any]
    
    init(date: Date, title: String, body: String, id: Int, member: [String: Any]) {
        self.date = date
        self.title = title
        self.body = body
        self.id = id
        self.member = member
    }
    
    convenience init?(dictionary: [String: Any]){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"

        guard  let dateAsString = dictionary["date"] as? String,
        let date = dateFormatter.date(from: dateAsString),
        let title = dictionary["title"] as? String,
        let body = dictionary["body"] as? String,
        let id = dictionary["id"] as? Int,
        let member = dictionary["member"] as? [String: Any] else {
            return nil
        }
        self.init(date: date, title: title, body: body, id: id, member: member)
    } 
}
