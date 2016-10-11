//
//  MembersTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/11/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class MembersTableViewController: UITableViewController {
    
    var members: [Member] = []
    var memberStore: MemberStore = MemberStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Members"
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
        memberStore.fetchMembers{
            (MembersResult) -> Void in
            
            switch MembersResult {
            case let .success(members):
                print("Successfully found \(members.count) members")
                OperationQueue.main.addOperation {
                    self.members = members
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print("Error fetching members: \(error)")
            }
        }
    }
    
}