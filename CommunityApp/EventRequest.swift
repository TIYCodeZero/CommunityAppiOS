//
//  EventRequest.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/14/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation


enum EventsResult {
    case success([Event])
    case failure(String)
    
    init(data: Data) {
        guard ((try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]) != nil else {
            self = .failure("Unexpected data format in posts response")
            return
        }
        fatalError()
    }
    
}

enum CreateEventResult {
    case success([Event])
    case failure(String)
    
    init(data: Data) {
        
        guard let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {
            self = .failure("Your effort to create an event was unsuccessful")
            return
        }
        guard let eventsArray = jsonObject["eventList"] as? [[String: Any]] else {
            self = .failure("You received data but no events list")
            return
        }
        let events = eventsArray.flatMap {
            (dictionary) in
            return Event(dictionary: dictionary)
        }
        guard events.count == eventsArray.count else {
            self = .failure("a dictionary was dropped from jsonObject")
            return
        }
        self = .success(events)
    }
        
}
