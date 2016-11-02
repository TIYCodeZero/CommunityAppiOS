//
//  InvitationRequest.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/18/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

enum Invitation {
    struct Request {
        var email: String
        
        
        init(email: String) {
            self.email = email
        }
        
    }
}

extension Invitation.Request {
        var jsonObject: [String: Any] {
            return ["email" : email]
        }
    
    func jsonData() throws -> Data {
        return try JSONSerialization.data(withJSONObject: jsonObject, options: [])
    }
}

extension Invitation {
    enum Response {
        enum Error {
            case invalidData([String: Any])
            case unexpected
        }
        
        enum Result {
            case success (String)
            case failure (Error)
            
            init(data: Data) {
                do {
                    let object: [String: Any] = try JSONSerialization.jsonObject(with: data, options: [])
                    if let message = object["successMessage"] as? String
                    {
                        self = .success(message)
                    } else {
                        self = .failure(.invalidData(object))
                    }
                } catch {
                    fatalError("error converting invitation response: \(error.localizedDescription)")
                }
            }
        }
    }
}
