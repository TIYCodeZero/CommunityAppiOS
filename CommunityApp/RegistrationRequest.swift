//
//  RegistrationRequest.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/09/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

enum Registration {
    struct Request {
        var firstName: String
        var lastName: String
        var email: String
        var streetAddress: String
        var password: String
//        var photoURL: String
        
        init(firstName: String, lastName: String, email: String, streetAddress: String, password: String/*, photoURL: String*/){
            self.firstName = firstName
            self.lastName = lastName
            self.email = email
            self.streetAddress = streetAddress
            self.password = password
//            self.photoURL = photoURL
        }
    }
}

extension Registration.Request {
    var jsonObject: [String: Any] {
        return [
            Member.firstNameKey : firstName,
            Member.lastNameKey : lastName,
            Member.emailKey : email,
            Member.streetAddressKey : streetAddress,
            Member.passwordKey : password/*,
            Member.photoURLKey : photoURL*/
        ]
    }
    
    func jsonData() throws -> Data {
        return try JSONSerialization.data(withJSONObject: jsonObject, options: [])
    }
}

extension Registration {
    enum Response {
        enum Error {
            case invalidData([String: Any])
            case unexpected
        }
        
        enum Result {
            case success (Member)
            case failure (Error)
            
            init(data: Data) {
                do {
                    let objects: [String: Any] = try JSONSerialization.jsonObject(with: data, options: [])
                    if let memberDict = objects["responseMember"] as? [String: Any],
                        let member = Member(dictionary: memberDict) {
                        self = .success(member)
                    } else {
                        self = .failure(.invalidData(objects))
                    }
                } catch JSONSerialization.CastingError.incompatibleType {
                    fatalError("Incompatible type in registration response")
                } catch {
                    fatalError("error converting registration response: \(error.localizedDescription)")
                }
            }
        }
    }
}
