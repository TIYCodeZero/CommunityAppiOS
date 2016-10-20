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
    
    var event: Event!
    var member: Member!
    var organization: Organization!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = event.name
        dateTextField.text = "\(event.date)"
        locationTextField.text = event.location
        organizationTextField.text = event.organization.name
        organizerTextField.text = "\(member.firstName) \(member.lastName)"
        informationLabel.text = event.information
    }
   
}
