//
//  OganizationStore.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/16/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

class OrganizationStore {
    
    var member: Member!
    var allOrgs: [Organization] = []
    
    func fetchOrgs(completionHandler: @escaping (OrgResult)-> Void) -> Void {
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.organizationList
        var request = URLRequest(url: method.url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (optData, optResponse, optError) in
            guard let data = optData else {
                let errorDescription = optResponse?.description ?? optError!.localizedDescription
                let orgResult: OrgResult = .failure(errorDescription)
                completionHandler(orgResult)
                return
            }
            completionHandler(.success(Organization.array(data: data)))
        }
        task.resume()
    }
    
       
}
