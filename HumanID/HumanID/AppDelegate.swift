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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        guard let component = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let params = component.queryItems else {
                print("invalid url")
                print("")
                return false
        }
        
        if let urlScheme = params.first(where: {
            $0.name == "urlScheme"
        })?.value {
            if let deviceID = KeyChain.retrieveString(key: .deviceIDKey) {
                callURLScheme(urlScheme: urlScheme, deviceID: deviceID)
            } else {
                let deviceID = UUID().uuidString
                
                KeyChain.isStoreSuccess(key: .deviceIDKey, value: deviceID)
                callURLScheme(urlScheme: urlScheme, deviceID: deviceID)
            }
        } else {
            return false
        }
        
        return true
    }
    
    func callURLScheme(urlScheme: String, deviceID: String) {
        guard let url = URL(string: "\(urlScheme):deviceID?deviceID=\(deviceID)") else {
            print("url scheme not valid")
            return
        }
        
        UIApplication.shared.open(url) {
            result in
            print(result)
        }
    }
}

