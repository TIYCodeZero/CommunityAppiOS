//
//  MemberEventsTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/19/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class MemberEventsTableViewController: UITableViewController {
    
    var member: Member?
    var events: [Event] = []
    var memberEvent: [Event] = []
    var eventStore: EventStore = EventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "\(member?.firstName) \(member?.lastName)'s Events"
        getEventsByMember {
            (EventsResult) -> Void in
            switch EventsResult {
            case let .success(events):
                print("Successfully found \(events.count) events")
                OperationQueue.main.addOperation {
                    self.events = events
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print("Error fetching events: \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberEventCell", for: indexPath) as! MemberEventCell
        let memberEvent = events[indexPath.row]
        cell.nameLabel.text = memberEvent.name
        cell.dateLabel.text = "\(memberEvent.date)"
        cell.eventLocation.text = memberEvent.location
        return cell
    }
    
    func displayErrorMessage(){
        CommunityApp.displayAlertMessage(title: "Error", message: "Unable to display member events", from: self)
    }
    
    func getEventsByMember(completionHandler: @escaping (EventsResult) -> Void) -> Void {
        let member = self.member!
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.eventsByMember
        var request = URLRequest(url: method.url)
        request.httpMethod = "POST"
        let memberProfile: [String: Any] = ["member": member.jsonObject]
        request.httpBody = try! JSONSerialization.data(withJSONObject: memberProfile, options: [])
        
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
