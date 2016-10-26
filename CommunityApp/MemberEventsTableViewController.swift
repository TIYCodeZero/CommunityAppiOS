//
//  MemberEventsTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/19/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class MemberEventsTableViewController: UITableViewController {
    
    var user: Member?
    var member: Member!
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
        title = "\(member!.firstName) \(member!.lastName)'s Events"
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
        cell.dateLabel.text = simpleDate(from: memberEvent.date)
        cell.eventLocation.text = memberEvent.location
        return cell
    }
    
    func displayErrorMessage(){
        CommunityApp.displayAlertMessage(title: "Alert", message: "\(member!.firstName) \(member!.lastName) has no events", from: self)
    }
    
    func getEventsByMember(completionHandler: @escaping (EventsResult) -> Void) -> Void {
        let member = self.member!
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.eventsByMember
        var request = URLRequest(url: method.url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: member.jsonObject, options: [])
        
        let task = session.dataTask(with: request) { (optData, optResponse, optError) in
            guard let data = optData else {
                let errorDescription = optResponse?.description ?? optError!.localizedDescription
                let eventsResult: EventsResult = .failure(errorDescription)
                completionHandler(eventsResult)
                return
            }
            let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as [String: Any]
            let eventDictionaries = jsonObject["eventList"] as? [[String: Any]]
            if eventDictionaries != nil {
            let events = Event.array(dictionaries: eventDictionaries!)
            completionHandler(.success(events))
            } else if jsonObject["errorMessage"] != nil {
                let someString = jsonObject["errorMessage"] as? String
                if (someString?.hasPrefix("Event list was empty"))! {
                    let events: [Event] = []
                    self.displayErrorMessage()
                    completionHandler(.success(events))
                }
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEventDetail" {
            if let row = (tableView.indexPathForSelectedRow as IndexPath?)?.row {
                let event = events[row]
                let eventDetailVC = segue.destination as! EventDetailViewController
                eventDetailVC.event = event
                eventDetailVC.member = member
            }
        }
    }
    
    func simpleDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = .medium
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.dateFormat = "MMM dd, yyyy, hh:mm a"
        let dateString = formatter.string(from: date)
        return dateString
    }
}
