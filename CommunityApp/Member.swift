//
//  Member.swift
//  Community
//
//  Created by Dan Esrey on 2016/04/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

class Member {
    
    public var firstName: String
    public var lastName: String
    public var email: String
    public var streetAddress: String
    public var id: Int
    public var password: String
    public var photoURL: String
//  public var imageKey: String
    
    init(firstName: String, lastName: String, email: String, streetAddress: String, id: Int, password: String, photoURL: String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.streetAddress = streetAddress
        self.id = id
        self.password = password
        self.photoURL = photoURL
//      self.imageKey = UUID().uuidString
    }
    
    convenience init?(dictionary: [String: Any]){
        guard let firstName = dictionary[Member.firstNameKey] as? String,
            let lastName = dictionary[Member.lastNameKey] as? String,
            let email = dictionary[Member.emailKey] as? String,
            let streetAddress = dictionary[Member.streetAddressKey] as? String,
            let id = dictionary[Member.idKey] as? Int,
//          let imageKey =
            let password = dictionary[Member.passwordKey] as? String,
            let photoURL = dictionary[Member.photoURLKey]  as? String else {
                return nil
        }
        self.init(firstName: firstName,
                  lastName: lastName,
                  email: email,
                  streetAddress: streetAddress,
                  id: id,
//                imageKey: imageKey,
                  password: password,
                  photoURL: photoURL)
    }
    
    var jsonObject: [String: Any] {
        return [
            Member.firstNameKey : firstName,
            Member.lastNameKey : lastName,
            Member.emailKey : email,
            Member.streetAddressKey : streetAddress,
            Member.idKey : id,
            Member.passwordKey : password,
            Member.photoURLKey : photoURL
//          Member.imageKey : imageKey
        ]
    }
    
    static func array(jsonDictionaries: [[String: Any]]) -> [Member] {
        let members = jsonDictionaries.flatMap(Member.init(dictionary:))
        guard jsonDictionaries.count == members.count else {
            fatalError("Failed to create member in array")
        }
        return members
    }
}

extension Member {
    static var firstNameKey: String = "firstName"
    static var lastNameKey: String = "lastName"
    static var emailKey: String = "email"
    static var streetAddressKey: String = "streetAddress"
    static var idKey: String = "id"
    static var passwordKey: String = "password"
    static var photoURLKey: String = "photoURL"
//  static var imageKey: String = "imageKey"
}

extension Member : Equatable {
    public static func == (lhs:Member, rhs:Member)->Bool {
        return (
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName &&
        lhs.email == rhs.email &&
        lhs.streetAddress == rhs.streetAddress &&
        lhs.id == rhs.id &&
//      lhs.imageKey = rhs.imageKey &&
        lhs.password == rhs.password &&
        lhs.photoURL == rhs.photoURL)
    }
    
}
