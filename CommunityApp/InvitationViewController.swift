//
//  InvitationViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/17/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit
import MessageUI

class InvitationViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var invitationInfoLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    
    var user: Member!
    var organization: Organization!
    var invitationRequest: Invitation.Request? {
        guard let email = emailTextField?.text,
            !email.isEmpty else {
                return nil
        }
        return Invitation.Request(email: email)
    }
    
    func displayAlertMessage() {
        CommunityApp.displayAlertMessage(title: "Error", message: "Please check your information and try again", from: self)
    }
    
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        emailTextField.resignFirstResponder()
    }
    
    @IBAction func sendInvitationButton(_ sender: AnyObject) {
        let composeVC = configuredMailComposeVC()
        if MFMailComposeViewController.canSendMail() {
            guard let email = emailTextField?.text,
                !email.isEmpty else {
                    displayAlertMessage()
                    return
            }
            let session = URLSession(configuration: CommunityAPI.sessionConfig)
            let method = CommunityAPI.Method.sendInvitation
            var request = URLRequest(url: method.url)
            request.httpMethod = "POST"
            let inviteProfile: [String: Any] = ["email": email, "organization": organization.jsonObject, "member": user.jsonObject]
            request.httpBody = try! JSONSerialization.data(withJSONObject: inviteProfile, options: [])
            session.dataTask(with: request) {(optData, optResponse, optError) in
                OperationQueue.main.addOperation {
                    guard let data = optData else {
                        self.displayAlertMessage()
                        return
                    }
                    switch Invitation.Response.Result(data: data) {
                    case let .success(message):
                        print(message)
                        composeVC.navigationBar.tintColor = .white
                        self.present(composeVC, animated: true, completion: nil)
                        return
                    case .failure:
                        self.displayAlertMessage()
                    }
                }
                }
                .resume()
        }
    }
    
    func configuredMailComposeVC() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        let email = emailTextField.text
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["\(email!)"])
        mailComposerVC.setSubject("Invite to Join Community")
        mailComposerVC.setMessageBody("You have been invited to join an organization in the Community App! To get started, visit the App Store and get Community. Then register as directed by the app.", isHTML: false)
        return mailComposerVC
    }
    
    func displaySendMailAlertMessage(){
        CommunityApp.displayAlertMessage(title: "Could not send invitation", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", from: self)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invitationInfoLabel.text = "Enter the email address of the person you would like to invite to join \(organization.name)"
    }
    
}
