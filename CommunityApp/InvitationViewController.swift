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

    var organization: Organization!
    
    @IBAction func sendInvitationButton(_ sender: AnyObject) {
        let composeVC = configuredMailComposeVC()
        if MFMailComposeViewController.canSendMail() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            self.displaySendMailAlertMessage()
        }
    }
    
    func configuredMailComposeVC() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
// Create fields for email to invitee
        mailComposerVC.setToRecipients(["\(emailTextField.text)"])
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
