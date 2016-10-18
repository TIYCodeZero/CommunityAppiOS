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
    var organization: [String: Any]
    
    init(date: Date, title: String, body: String, id: Int, member: [String: Any], organization: [String: Any]) {
        self.date = date
        self.title = title
        self.body = body
        self.id = id
        self.member = member
        self.organization = organization
    }
    
    convenience init?(dictionary: [String: Any]){
        let dateFormatter = ISO8601DateFormatter()
        guard  let dateAsString = dictionary["date"] as? String,
        let date = dateFormatter.date(from: dateAsString),
        let title = dictionary["title"] as? String,
        let body = dictionary["body"] as? String,
        let id = dictionary["id"] as? Int,
        let member = dictionary["member"] as? [String: Any],
        let organization = dictionary ["organization"] as? [String: Any] else {
            return nil
        }
        self.init(date: date, title: title, body: body, id: id, member: member, organization: organization)
    }
    
    static func array(data: Data) -> [Post] {
        guard let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]] else {
             fatalError("Failed to convert json into array of Post descriptions")
        }
        return array(dictionaries: jsonObject)
    }
    
    static func array(dictionaries: [[String: Any]]) -> [Post] {
        let posts = dictionaries.flatMap {
            (dictionary) in
            return Post(dictionary: dictionary)
        }
        guard posts.count == dictionaries.count else {
            fatalError("a dictionary was dropped from jsonObject")
        }
        return posts
    }
}

