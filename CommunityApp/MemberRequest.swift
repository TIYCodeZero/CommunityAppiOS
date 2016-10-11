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

func membersFromJSONData(_ data: Data)-> MembersResult {
    do {
        let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: [])
        guard let
            membersArray = jsonObject as? [[String: AnyObject]] else {
                return .failure("Cannot create array of members from jsonObject.")
        }
        var finalMembers = [Member]()
        for memberJSON in membersArray {
            if let member = memberFromJSONObject(memberJSON){
                finalMembers.append(member)
            }
        }
        if finalMembers.count == 0 && !membersArray.isEmpty == false {
            return .failure("unsuccessful creating member from jsonObject")
        }
        return .success(finalMembers)
    }
    catch _ {
        return .failure("things went wrong somewhere")
    }
}

fileprivate func memberFromJSONObject(_ json: [String:Any])-> Member? {
    guard let
        firstName = json["firstName"] as? String,
        let lastName = json["lastName"] as? String,
        let email = json["email"] as? String,
        let id = json["id"] as? Int,
        let password = json["password"] as? String,
        let streetAddress = json["streetAddress"] as? String else {
            return nil
    }
    let member = Member(firstName: firstName, lastName: lastName, email: email, streetAddress: streetAddress, id: id, password: password)
    return member
}
