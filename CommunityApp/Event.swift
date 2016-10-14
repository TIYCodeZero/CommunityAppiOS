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
    
    internal static let dateFormatter = ISO8601DateFormatter()
    internal static func scrub(_ date: Date) -> Date {
        let dateString = Event.dateFormatter.string(from: date)
        return dateFormatter.date(from: dateString)!
    }
    
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
            let dateString = dictionary[Event.dateKey] as? String,
            let date = Event.dateFormatter.date(from: dateString),
            let location = dictionary[Event.locationKey] as? String,
            let information = dictionary[Event.informationKey] as? String,
            let organizerInfo = dictionary[Event.organizerKey] as? [String: Any],
            let organizer = Member(dictionary: organizerInfo),
            let attendeeInfo = dictionary[Event.attendeesKey] as? [[String: Any]] else {
                return nil
        }
        
        let attendees = Member.array(jsonDictionaries: attendeeInfo)
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

extension Event : Equatable {
    public static func ==(lhs: Event, rhs: Event) -> Bool {
        return (lhs.name == rhs.name &&
            lhs.date == rhs.date &&
            lhs.location == rhs.location &&
            lhs.information == rhs.information &&
            lhs.organizer == rhs.organizer &&
            lhs.attendees == rhs.attendees
        )
    }
    
}
