//
//  CreateEventViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/15/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    var user: Member?

    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var locationLabel: UITextField!
    @IBOutlet var informationLabel: UITextField!
    @IBOutlet var date: UIDatePicker!
    
    
    @IBAction func saveEvent(_ sender: AnyObject) {
        let organizer = user!
        
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
        
        let eventProfile: [String: Any] = ["date": date, "name": name, "location": location, "information": information, "organizer": organizer.jsonObject]
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: eventProfile, options: [])
        session.dataTask(with: request) { (optData, optResponse, optError) in
            OperationQueue.main.addOperation {
                guard let data = optData else {
                    self.displayAlertMessage()
                    return
                }
                switch CreateEventResult(data: data) {
                case .success:
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


}
