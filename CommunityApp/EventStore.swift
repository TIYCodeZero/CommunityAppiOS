//
//  EventStore.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/14/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit


class EventStore {
    
    
    var allEvents: [Event] = []
    
    func fetchEvents(completionHandler: @escaping (EventsResult) -> Void) -> Void {
            completionHandler(.failure("we didn't even try."))
        
//        let session = URLSession(configuration: CommunityAPI.sessionConfig)
//        let method = CommunityAPI.Method.memberDirectory
//        var request = URLRequest(url: method.url)
//        
//        request.httpMethod = "GET"
//        
//        let task = session.dataTask(with: request) { (optData, optResponse, optError) in
//            guard let data = optData else {
//                let errorDescription = optResponse?.description ?? optError!.localizedDescription
//                let eventsResult: EventsResult = .failure(errorDescription)
//                completionHandler(eventsResult)
//                return
//            }
//            completionHandler(EventsResult(data: data))
//        }
//        task.resume()
    }
    
}
