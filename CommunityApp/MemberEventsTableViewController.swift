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
    var memberEvents: [Event] = []
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberEventCell", for: indexPath) as! MemberEventCell
        
        
        return cell
    }
}
