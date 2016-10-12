//
//  MenuViewController.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/11/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var user: Member?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func viewMembersButton(_ sender: AnyObject) {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CreatePostViewController {
            destination.user = self.user
        }
        
    }
    
}
