//
//  EventsListTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/14/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class EventsListTableViewController: UITableViewController {

    var user: Member?
    var events: [Event] = []
    var eventStore: EventStore = EventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Events"
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        eventStore.fetchEvents {
            (EventsResult) -> Void in
            
            switch EventsResult {
            case let .success(events):
                print("Successfully found \(events.count) events.")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = events[indexPath.row]
        cell.nameLabel.text = event.name
        cell.dateLabel.text = "\(event.date)"
        cell.locationLabel.text = event.location
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEventDetail" {
            if let row = (tableView.indexPathForSelectedRow as IndexPath?)?.row {
                let event = events[row]
                let eventDetailVC = segue.destination as! EventDetailViewController
                eventDetailVC.event = event
                eventDetailVC.member = user
            }
            
        }
    }

   
}
