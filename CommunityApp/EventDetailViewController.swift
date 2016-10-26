//
//  EventDetailViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/20/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var organizationTextField: UITextField!
    @IBOutlet var organizerTextField: UITextField!
    @IBOutlet var informationLabel: UILabel!
    
    var user: Member?
    var event: Event!
    var member: Member!
    var organization: Organization!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = event.name
        dateTextField.text = simpleDate(from: event.date)
        locationTextField.text = event.location
        organizationTextField.text = event.organization.name
        organizerTextField.text = "\(event.organizer.firstName) \(event.organizer.lastName)"
        informationLabel.text = event.information
        nameTextField.isEnabled = false
        dateTextField.isEnabled = false
        locationTextField.isEnabled = false
        organizationTextField.isEnabled = false
        organizerTextField.isEnabled = false
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
