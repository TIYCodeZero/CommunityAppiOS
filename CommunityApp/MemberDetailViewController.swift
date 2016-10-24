//
//  MemberDetailViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/11/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var toolbar: UIToolbar!
 
    var member: Member!
    
    @IBAction func cameraButtonTapped(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImage(member.photoURL)
        nameField.text = "\(member.firstName) \(member.lastName)"
        addressField.text = member.streetAddress
        emailField.text = member.email
        toolbar.isHidden = true
        nameField.isEnabled = false
        addressField.isEnabled = false
        emailField.isEnabled = false
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewMemberPosts" {
           let memberPostsTableViewController = segue.destination as! MemberPostsTableViewController
            memberPostsTableViewController.member = member
        }
        if segue.identifier == "ViewMemberEvents" {
            let memberEventsTableViewController = segue.destination as! MemberEventsTableViewController
            memberEventsTableViewController.member = member
        }
    }
    
    func loadImage(_ urlString:String) {
        let imageURL: URL = URL(string: urlString)!
        let request: URLRequest = URLRequest(url: imageURL)
        let session = URLSession(configuration: CommunityAPI.sessionConfig)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if (error == nil && data != nil) {
                func display_image() {
                    self.imageView.image = UIImage(data: data!)
                }
                DispatchQueue.main.async(execute: display_image)
            }
        })
        task.resume()
    }
    
}
