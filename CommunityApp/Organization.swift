//
//  Organization.swift
//  Community
//
//  Created by Dan Esrey on 2016/04/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation


class Organization {
    
    public var name: String
    public var id: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    convenience init?(dictionary: [String: Any]){
        guard let name = dictionary["name"] as? String,
            let id = dictionary["id"] as? Int else {
                return nil
        }
        self.init(name: name, id: id)
    }
    
    var jsonObject: [String: Any] {
        return [
            Organization.nameKey: name,
            Organization.idKey: id
        ]
    }
    
    static func array(data: Data) -> [Organization] {
        guard let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]] else {
            fatalError("Failed to convert json into array of Org descriptions")
        }
        return array(dictionaries: jsonObject)
    }
    
    static func array(dictionaries: [[String: Any]]) -> [Organization] {
        let organizations = dictionaries.flatMap {
            (dictionary) in
            return Organization(dictionary: dictionary)
        }
        guard organizations.count == dictionaries.count else {
            fatalError("a dictionary was dropped from jsonObject")
        }
        return organizations
    }
    
}

extension Organization {
    static var nameKey: String = "name"
    static var idKey: String = "id"
}

extension Organization : Equatable {
    public static func == (lhs:Organization, rhs:Organization)->Bool {
        return (
        lhs.name == rhs.name &&
        lhs.id == rhs.id)
    }
}

