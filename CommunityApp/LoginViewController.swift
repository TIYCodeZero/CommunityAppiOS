//
//  LoginViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/07/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

internal func displayAlertMessage(title: String, message: String, from controller: UIViewController)-> Void {
    let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle(rawValue: 1)!)
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
    myAlert.addAction(okAction)
    controller.present(myAlert, animated: true, completion: nil)
}

final class LoginViewController: UIViewController {
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    var loginRequest: Login.Request? {
        guard let email = emailField?.text,
            let password = passwordField?.text,
            !email.isEmpty,
            !password.isEmpty else {
                return nil
        }
        return Login.Request (email: email, password: password)
    }
    
    func displayAlertMessage(){
        CommunityApp.displayAlertMessage(title: "Error", message: "Please check credentials and try again", from: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            title = "Login to Community"
    }
    
    @IBAction func loginButton (_ sender: AnyObject){
        guard let loginReq = loginRequest else {
            displayAlertMessage()
            return
        }
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.login
        var request = URLRequest(url: method.url)
        request.httpMethod = "POST"
        request.httpBody = try! loginReq.jsonData()
        session.dataTask(with: request) { (optData, optResponse, optError) in
            OperationQueue.main.addOperation {
                guard let data = optData else {
                    self.displayAlertMessage()
                    return
                }
                switch Login.Response.Result(data: data) {
                case let .success(user):
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let navController = storyboard.instantiateViewController(withIdentifier: "MainNav") as! UINavigationController
                    let mainVC = navController.topViewController as! MemberOrganizationsViewController
                    mainVC.user = user
                    self.present(navController, animated: true, completion: nil)
                    return
                case .failure:
                    self.displayAlertMessage()
                }
            }
            }
            .resume()
    }
    
    @IBAction func dismissKeyboard(_ sender: AnyObject){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
}
