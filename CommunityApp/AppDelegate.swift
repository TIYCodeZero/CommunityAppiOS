//
//  AppDelegate.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/07/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 0, green: 121/255, blue: 1, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)]
        UINavigationBar.appearance().tintColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
         return true
    }

 
}

