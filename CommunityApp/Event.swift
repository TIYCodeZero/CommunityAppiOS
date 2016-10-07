//
//  Event.swift
//  Community
//
//  Created by Dan Esrey on 2016/04/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation


class Event {
    
    public var name: String
    public var date: Date
    public var location: String
    public var information: String
    public var organizer: Member
    public var attendees: [Member]
    
    init(name: String, date: Date, location: String, information: String, organizer: Member, attendees: [Member]){
        self.name = name
        self.date = date
        self.location = location
        self.information  = information
        self.organizer = organizer
        self.attendees = attendees
    }
    
    convenience init?(dictionary: [String: Any]){
        guard  let name = dictionary[Event.nameKey] as? String,
        let date = dictionary[Event.dateKey] as? Date,
        let location = dictionary[Event.locationKey] as? String,
        let information = dictionary[Event.informationKey] as? String,
        let organizer = dictionary[Event.organizerKey] as? Member,
        let attendees = dictionary[Event.attendeesKey] as? [Member] else {
            return nil
        }
        self.init(name: name, date: date, location: location, information: information, organizer: organizer, attendees: attendees)
    }
}

extension Event {
    static var nameKey: String = "name"
    static var dateKey: String = "date"
    static var locationKey: String = "location"
    static var informationKey: String = "information"
    static var organizerKey: String = "organizer"
    static var attendeesKey: String = "attendees"
    
}
