//
//  CreatePostViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/12/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    
/*    @IBAction func nextButton(_ sender: AnyObject) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        let date = dateFormatter.string(from: currentDate)
        let author =
        guard let title = titleField.text,
        let body = bodyField.text else {
            CommunityApp.displayAlertMessage(title: "Error", message: "All fields are required", from: self)
            return
        }
    } */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post"
    }
 
/*    class func createPost(date: String, title: String, body: String, author: Member, completionHandler: @escaping (PostsResult) -> Void) -> Void {
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let method = CommunityAPI.Method.createPost
        var request = URLRequest(url: method.url)
        request.httpMethod = "POST"
        
        let postProfile: [String: String] = ["date": date, "title": title, "body": body, "author": author]
        
        request.httpBody = try
    } */
}
