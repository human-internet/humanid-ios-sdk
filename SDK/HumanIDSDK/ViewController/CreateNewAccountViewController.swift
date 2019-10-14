//
//  CreateNewAccountViewController.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 14/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit

class CreateNewAccountViewController: UIViewController {

    var phoneNumber = ""
    
    convenience init(phoneNumber: String) {
        self.init(nibName: "VerifyPhoneViewController", bundle: Bundle(identifier: "org.humanid.HumanIDSDK"))
        
        self.phoneNumber = phoneNumber
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
