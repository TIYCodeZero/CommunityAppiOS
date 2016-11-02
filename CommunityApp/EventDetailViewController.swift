//
//  EventDetailViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/20/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet var informationLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var communityLabel: UILabel!
    @IBOutlet var organizerLabel: UILabel!
    
    var user: Member?
    var event: Event!
    var member: Member!
    var organization: Organization!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = event.name
        dateLabel.text = simpleDate(from: event.date)
        locationLabel.text = event.location
        communityLabel.text = event.organization.name
        organizerLabel.text = "\(event.organizer.firstName) \(event.organizer.lastName)"
        informationLabel.text = event.information
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
