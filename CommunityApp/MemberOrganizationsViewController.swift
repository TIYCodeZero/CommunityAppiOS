//
//  MemberOrganizationsViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/27/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class MemberOrganizationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user: Member!
    var organizations: [Organization] = []
    var organizationStore: OrganizationStore = OrganizationStore()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = "\(user.firstName) \(user.lastName)'s Communities"
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
        
    override func viewWillAppear(_ animated: Bool) {
        fetchOrgsByMember {
            (OrgResult) -> Void in
            switch OrgResult {
            case let .success(organizations):
                print("Successfully found \(organizations.count) communities.")
                OperationQueue.main.addOperation {
                    self.organizations = organizations
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print("Error fetching communities: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberOrgCell", for: indexPath) as! MemberOrgCell
        let organization = organizations[indexPath.row]
        cell.nameLabel.text = organization.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewOrgDetails" {
            if let row = (tableView.indexPathForSelectedRow as IndexPath?)?.row {
                let organization = organizations[row]
                let viewOrgDetailsVC = segue.destination as! OrgDetailViewController
                viewOrgDetailsVC.organization = organization
                viewOrgDetailsVC.user = user
            }
        }
        if let destination = segue.destination as? MemberDetailViewController {
            destination.member = self.user
        }

    }
    
    func fetchOrgsByMember(completionHandler: @escaping (OrgResult)-> Void) -> Void {
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.membersOrgs
        var request = URLRequest(url: method.url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: user.jsonObject, options: [])
        let task = session.dataTask(with: request) { (optData, optResponse, optError) in
            guard let data = optData else {
                let errorDescription = optResponse?.description ?? optError!.localizedDescription
                let orgResult: OrgResult = .failure(errorDescription)
                completionHandler(orgResult)
                return
            }
            let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as [String:Any]
            let orgDictionaries = jsonObject["responseOrganization"] as? [[String: Any]]
            let orgs = Organization.array(dictionaries: orgDictionaries!)
            completionHandler(.success(orgs))
        }
        task.resume()
    }
    



}
