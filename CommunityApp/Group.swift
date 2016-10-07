//
//  Group.swift
//  Community
//
//  Created by Dan Esrey on 2016/04/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation


class Group {
    
    public var name: String
    public var members: [Member]
    
    init(name: String, members: [Member]) {
        self.name = name
        self.members = members
    }
    
    convenience init?(dictionary: [String: Any]){
        guard let name = dictionary["name"] as? String,
            let members = dictionary["members"] as? [Member] else {
                return nil
        }
        self.init(name: name, members: members)
    }
}
