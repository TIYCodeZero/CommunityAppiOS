//
//  OrgEventsTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/18/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class OrgEventsTableViewController: UITableViewController {
    
    var events: [Event] = []
    var eventStore: EventStore = EventStore()
    var organization: Organization!
    
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
        title = "\(organization.name) Events"
        getMemberEvents {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrgEventsCell", for: indexPath) as! OrgEventsCell
        let event = events[indexPath.row]
        cell.nameLabel.text = event.name
        cell.dateLabel.text = "\(event.date)"
        cell.eventLocation.text = event.location
        return cell
    }
    
    func getMemberEvents(completionHandler: @escaping (EventsResult) -> Void) -> Void {
        let organization = self.organization!
        let name = organization.name
        let id = organization.id
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.eventsByOrg
        var request = URLRequest(url: method.url)
        request.httpMethod = "POST"
        
        let orgEventProfile: [String: Any] = ["name": name, "id": id]
        request.httpBody = try! JSONSerialization.data(withJSONObject: orgEventProfile, options: [])
        
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

        
        

