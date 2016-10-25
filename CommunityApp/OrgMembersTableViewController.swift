//
//  OrgMembersTableViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/20/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class OrgMembersTableViewController: UITableViewController {

    var organization: Organization!
    var members: [Member] = []
    var memberStore:MemberStore = MemberStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(organization.name) Members"
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

// replace fetchMembers
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrgMemberCell", for: indexPath) as! OrgMemberCell
        let member = members[indexPath.row]
        cell.nameLabel.text = "\(member.lastName), \(member.firstName)"
        cell.addressLabel.text = member.streetAddress
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMemberDetail" {
            if let row = (tableView.indexPathForSelectedRow as IndexPath?)?.row {
                let member = members[row]
                let memberDetailViewController = segue.destination as! MemberDetailViewController
                memberDetailViewController.member = member
                memberDetailViewController.organization = organization
                memberDetailViewController.toolbar.isHidden = true
            }
        }
    }

    func getOrgMembers (completionHandler: @escaping (MembersResult) -> Void) -> Void {
        let organization = self.organization!
        let name = organization.name
        let id = organization.id
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.membersByOrg
        var request = URLRequest(url: method.url)
        request.httpMethod = "POST"
        
        let orgMemberProfile: [String: Any] = ["name": name, "id": id]
        request.httpBody = try! JSONSerialization.data(withJSONObject: orgMemberProfile, options: [])
        
        let task = session.dataTask(with: request) { (optData, optResponse, optError) in
            guard let data = optData else {
                let errorDescription = optResponse?.description ?? optError!.localizedDescription
                let membersResult: MembersResult = .failure(errorDescription)
                completionHandler(membersResult)
                return
            }
            let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as [String: Any]
            let memberDictionaries = jsonObject["memberList"] as? [[String: Any]]
            let members = Member.array(jsonDictionaries: memberDictionaries!)
            completionHandler(.success(members))
        }
        task.resume()
    }
    
}
