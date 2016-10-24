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
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.eventList
        var request = URLRequest(url: method.url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (optData, optResponse, optError) in
            guard let data = optData else {
                let errorDescription = optResponse?.description ?? optError!.localizedDescription
                let eventsResult: EventsResult = .failure(errorDescription)
                completionHandler(eventsResult)
                return
            }
            let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as [String: Any]
            let eventDictionaries = jsonObject["eventList"] as? [[String: Any]]
            let events = Event.array(dictionaries: eventDictionaries!)
            completionHandler(.success(events))
        }
        task.resume()
    }
    
}
