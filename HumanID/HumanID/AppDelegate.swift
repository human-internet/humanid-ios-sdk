//
//  AppDelegate.swift
//  HumanID
//
//  Created by fanni suyuti on 07/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func setupMainWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = ViewController()
        let navCon = UINavigationController(rootViewController: vc)
        window?.rootViewController = navCon
        
        window?.makeKeyAndVisible()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupMainWindow()
        return true
    }
}

