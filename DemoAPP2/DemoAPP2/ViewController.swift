//
//  ViewController.swift
//  DemoAPP2
//
//  Created by fanni suyuti on 11/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit
import HumanID

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HumanID.shared.verifyPhone(phoneNumber: "085659030344", countryCode: "+62") { success, message in
            print(success)
            print(message)
        }
        
        HumanID.shared.userRegistration(phoneNumber: "085659030344", countryCode: "+62", verificationCode: "0000") { success, message in
            print(success)
            print(message)
        }
    }


}
