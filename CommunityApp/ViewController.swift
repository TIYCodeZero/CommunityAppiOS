//
//  ViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/10/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
}

extension ViewController: MemberAuthenViewControllerDelegate {
    func loginViewController(_ controller: UIViewController, successfullyAuthenticated member: Member) {
        print("Success:  \(member)")
        controller.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
