//
//  OrgDetailViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/17/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class OrgDetailViewController: UIViewController {
    
    var user: Member!
    var organization: Organization!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = organization.name
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InviteMembers" {
            let orgInviteVC = segue.destination as! InvitationViewController
            orgInviteVC.organization = organization
            orgInviteVC.user = user
        }
        if segue.identifier == "ShowOrgPosts" {
            let orgPostsVC = segue.destination as! OrgPostsTableViewController
            orgPostsVC.organization = organization
            orgPostsVC.user = user
        }
        if segue.identifier == "ShowOrgEvents" {
            let orgEventsVC = segue.destination as! OrgEventsTableViewController
            orgEventsVC.organization = organization
            orgEventsVC.user = user
        }
        if segue.identifier == "ShowOrgMembers" {
            let orgMembersVC = segue.destination as! OrgMembersTableViewController
            orgMembersVC.organization = organization
            orgMembersVC.user = user
        }
    }
}
