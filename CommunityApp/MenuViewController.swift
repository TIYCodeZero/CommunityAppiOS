//
//  MenuViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/11/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var user: Member?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MemberDetailViewController {
            destination.member = self.user
            destination.toolbar.isHidden = false

        }
        if let destination = segue.destination as? MemberOrgsViewController {
            destination.user = self.user
        }
        if let destination = segue.destination as? MemberPostsTableViewController {
            destination.member = self.user
        }
    }
    
}
