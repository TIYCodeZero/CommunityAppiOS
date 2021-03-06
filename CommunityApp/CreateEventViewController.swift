//
//  CreateEventViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/15/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    var user: Member!
    var organization: Organization!

    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var locationLabel: UITextField!
    @IBOutlet var informationLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerAction(_ sender: AnyObject) {
    }
    
    @IBAction func createEvent(_ sender: AnyObject) {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.string(from: datePicker.date)
        guard let name = nameLabel.text,
            let location = locationLabel.text,
            let information = informationLabel.text else {
                CommunityApp.displayAlertMessage(title: "Error", message: "All fields are required", from: self)
                return
        }
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.createEvent
        var request = URLRequest(url: method.url)
        request.httpMethod = "POST"
        let eventProfile: [String: Any] = ["date": date, "name": name, "location": location, "information": information, "organizer": user.jsonObject, "organization": organization.jsonObject]
        request.httpBody = try! JSONSerialization.data(withJSONObject: eventProfile, options: [])
        session.dataTask(with: request) { (optData, optResponse, optError) in
            OperationQueue.main.addOperation {
                guard let data = optData else {
                    self.displayAlertMessage()
                    return
                }
                switch CreateEventResult(data: data) {
                case .success:
                    _ = self.navigationController?.popViewController(animated: true)
                    return
                case let .failure(message):
                    print("💜\(message)")
                    self.displayAlertMessage()
                }
            }
            }
            .resume()
    }
    
    func displayAlertMessage(){
        CommunityApp.displayAlertMessage(title: "Error", message: "Unable to create event", from: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Event"
    }
    
    @IBAction func dismissKeyboard (_ sender: AnyObject){
        nameLabel.resignFirstResponder()
        locationLabel.resignFirstResponder()
        informationLabel.resignFirstResponder()
    }
    
}
