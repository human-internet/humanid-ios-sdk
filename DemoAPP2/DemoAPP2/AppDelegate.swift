//
//  AppDelegate.swift
//  DemoAPP2
//
//  Created by fanni suyuti on 11/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit
import HumanIDSDK

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
        
        HumanIDSDK.shared.config(appID: "DEMO_APP_IOS", appSecret: "541ec90bf636f0a8847885af37faedc258dcc875481f870d507c64d0e785bc1e")
        HumanIDSDK.shared.registerNotification(token: "asdasdasdasdasd")
        
        setupMainWindow()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let component = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let params = component.queryItems else {
//                print("invalid url")
                return false
        }
        
        if let deviceID = params.first(where: {
            $0.name == "deviceID"
        })?.value {
                HumanIDSDK.shared.setDeviceID(id: deviceID)
            } else {
//            print(url.absoluteString)
            return false
        }
        
        return true
    }
}

