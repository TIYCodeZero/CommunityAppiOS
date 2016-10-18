//
//  CreatePostViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/12/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    var user: Member?
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    
    @IBAction func nextButton(_ sender: AnyObject) {
        let currentDate = Date()
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.string(from: currentDate)
        let member = user!
        guard let title = titleField.text,
            let body = bodyField.text else {
                CommunityApp.displayAlertMessage(title: "Error", message: "All fields are required", from: self)
                return
        }
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.createPost
        var request = URLRequest(url: method.url)
        request.httpMethod = "POST"
        let postProfile: [String: Any] = ["date": date, "title": title, "body": body, "member": member.jsonObject]
        request.httpBody = try! JSONSerialization.data(withJSONObject: postProfile, options: [])
        session.dataTask(with: request) { (optData, optResponse, optError) in
            OperationQueue.main.addOperation {
                guard let data = optData else {
                    self.displayAlertMessage()
                    return
                }
                switch CreatePostResult(data: data) {
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
        CommunityApp.displayAlertMessage(title: "Error", message: "Unable to create post", from: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Post"
    }    
    
}
