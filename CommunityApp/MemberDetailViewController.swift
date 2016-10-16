//
//  MemberDetailViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/11/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var emailField: UITextField!
 
    var member: Member!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = "\(member.firstName) \(member.lastName)"
        addressField.text = member.streetAddress
        emailField.text = member.email
        
    }

 
}
