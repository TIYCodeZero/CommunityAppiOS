//
//  LoginRequest.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/09/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

enum Login {
    struct Request {
        var email: String
        var password: String
        
        init(email: String, password: String) {
            self.email = email
            self.password = password
        }
    }
}

extension Login.Request {
    var jsonObject: [String: Any] {
        return [
        Member.emailKey : email,
        Member.passwordKey : password
        ]
    }

    func jsonData() throws -> Data {
        return try JSONSerialization.data(withJSONObject: jsonObject, options: [])
    }
}

extension Login {
    enum Response {
        enum Error : Swift.Error {
            case invalidData([String: Any])
            case unexpected
        }
        
        enum Result {
            case success(Member)
            case failure(Error)
            
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
                    fatalError("Incompatible type in login response")
                } catch {
                    fatalError("error converting login response: \(error.localizedDescription)")
                }
            }
        }
    }
}
