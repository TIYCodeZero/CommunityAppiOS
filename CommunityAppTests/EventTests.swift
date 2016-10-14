//
//  EventTests.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/14/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import XCTest
@testable import CommunityApp

class EventTests: XCTestCase {
    
    func testInitWithDictionary() {
        
        
        let date: Date = Event.scrub(Date())


        let name = "Keymaster"
        let location = "Tower"
        let information = "Are you?"
        let organizer = Member(firstName: "Gozer", lastName: "The gozerian", email: "gozeri@an.com", streetAddress: "Somewhere else", id: 3421, password: "1209")
        let attendees: [Member] = []
        
        
        
        let source: [String: Any] = [
            Event.nameKey : name,
            Event.dateKey : Event.dateFormatter.string(from: date),
            Event.locationKey : location,
            Event.informationKey : information,
            Event.organizerKey : organizer.jsonObject,
            Event.attendeesKey : attendees.map({ $0.jsonObject })
        ]
        
        guard let result = Event(dictionary: source) else {
            XCTFail("Failed to create event with dictionary: \(source)")
            return
        }
        let expected = Event(name: name, date: date, location: location, information: information, organizer: organizer, attendees: attendees)
        
        XCTAssertEqual(result, expected)
    }
    
    func testEquality() {
        let gozer1 = Member(firstName: "Gozer", lastName: "The gozerian", email: "gozeri@an.com", streetAddress: "Somewhere else", id: 3421, password: "1209")
        let gozer2 = Member(firstName: "Gozer", lastName: "The gozerian", email: "gozeri@an.com", streetAddress: "Somewhere else", id: 3421, password: "1209")
        let ray = Member(firstName: "Ray", lastName: "", email: "Ray@gbs.com    ", streetAddress: "Somewhere", id: 339, password: "38907")
        
        XCTAssertEqual(gozer1, gozer2)
        XCTAssertEqual(gozer2, gozer1)
        XCTAssertNotEqual(gozer1, ray)
        XCTAssertNotEqual(ray, gozer1)
        XCTAssertNotEqual(gozer2, ray)
        XCTAssertNotEqual(ray, gozer2)        
    }
    
}
