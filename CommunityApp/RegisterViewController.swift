//
//  RegisterViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/10/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var streetAddressField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var confirmPasswordField: UITextField!
    
    // Not sure I need a delegate here
    var delegate: MemberAuthenViewControllerDelegate?
    
    var registrationRequest: Registration.Request? {
        guard let firstName = firstNameField?.text,
            let lastName = lastNameField?.text,
            let email = emailField?.text,
            let streetAddress = streetAddressField?.text,
            let password = passwordField?.text,
            let confirmPassword = confirmPasswordField?.text,
            !lastName.isEmpty,
            !firstName.isEmpty,
            !email.isEmpty,
            !streetAddress.isEmpty,
            !password.isEmpty,
            password == confirmPassword else {
                return nil
        }
        return Registration.Request(firstName: firstName, lastName: lastName, email: email, streetAddress: streetAddress, password: password)
    }
    
    func displayAlertMessage() {
        CommunityApp.displayAlertMessage(title: "Error", message: "Please check your information and try again", from: self)
    }
    
    @IBAction func registerButton(_ sender: AnyObject) {
        guard let regReq = registrationRequest else {
            displayAlertMessage()
            return
        }
        
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.register
        var request = URLRequest(url: method.url)
        
        request.httpMethod = "POST"
        request.httpBody = try! regReq.jsonData()
        
        session.dataTask(with: request) { (optData, optResponse, optError) in
            OperationQueue.main.addOperation {
                guard let data = optData else {
                    self.displayAlertMessage()
                    return
                }
                switch Registration.Response.Result(data: data) {
                case .success:
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MainNav")
                    self.present(vc, animated: true, completion: nil)
                    return
                case .failure:
                    self.displayAlertMessage()
                }
            }
            }
            .resume()
    }
}
