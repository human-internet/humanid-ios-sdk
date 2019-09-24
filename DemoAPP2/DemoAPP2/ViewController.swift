//
//  ViewController.swift
//  DemoAPP2
//
//  Created by fanni suyuti on 11/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit
import SDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SDK.HumanID.shared.config(appID: "appid", appSecret: "appsecret")
        
        
        SDK.HumanID.shared.verifyPhone(phoneNumber: "08598234", countryCode: "+62") { success, message in
            print(success)
            print(message)
        }
    }


}
