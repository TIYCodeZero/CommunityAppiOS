//
//  OrganizationsTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/16/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class OrganizationsTableViewController: UITableViewController {

    var user: Member?
    var organizations: [Organization] = []
    var organizationStore: OrganizationStore = OrganizationStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Organizations"
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        organizationStore.fetchOrgs {
            (OrgResult) -> Void in
            switch OrgResult {
            case let .success(organizations):
                print("Successfully found \(organizations.count) organizations.")
                OperationQueue.main.addOperation {
                    self.organizations = organizations
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print("Error fetching organizations: \(error)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrgCell", for: indexPath) as! OrganizationCell
        let organization = organizations[indexPath.row]
        cell.nameLabel.text = organization.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowOrgDetail" {
            if let row = (tableView.indexPathForSelectedRow as IndexPath?)?.row {
                let organization = organizations[row]
                let orgDetailVC = segue.destination as! OrgDetailViewController
                orgDetailVC.organization = organization
                orgDetailVC.user = user
            }            
        }
    }
    
}
