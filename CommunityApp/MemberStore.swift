//
//  MemberStore.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/11/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit


class MemberStore {
    
    var allMembers: [Member] = []
    
    
    func fetchMembers (completionHandler: @escaping (MembersResult) -> Void) -> Void {
        
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.memberDirectory
        var request = URLRequest(url: method.url)
        
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (optData, optResponse, optError) in
            guard let data = optData else {
                let errorDescription = optResponse?.description ?? optError!.localizedDescription
                let membersResult: MembersResult = .failure(errorDescription)
                completionHandler(membersResult)
                return
            }
            completionHandler(MembersResult(data: data))
        }
        task.resume()
    }
    
}



/*    func processMembersRequest (data: Data?, error: NSError?)-> MembersResult{
        guard let jsonData = data else {
            return .failure("Unable to process members request")
        }
        return membersFromJSONData(jsonData)
    } */
