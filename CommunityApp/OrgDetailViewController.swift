//
//  OrgDetailViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/17/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class OrgDetailViewController: UIViewController {
    
    var organization: Organization!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = organization.name
    }
    
    @IBAction func viewMembers(_ sender: AnyObject) {
        
    }
    
    @IBAction func sendInvitation(_ sender: AnyObject) {
        
    }
    
    @IBAction func viewPosts(_ sender: AnyObject) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InviteMembers" {
            let orgInviteVC = segue.destination as! InvitationViewController
            orgInviteVC.organization = organization
        }
        if segue.identifier == "ShowOrgPosts" {
            let orgPostsVC = segue.destination as! OrgPostsTableViewController
            orgPostsVC.organization = organization
        }
        if segue.identifier == "ShowOrgEvents" {
            let orgEventsVC = segue.destination as! OrgEventsTableViewController
            orgEventsVC.organization = organization
        }
    }
}
