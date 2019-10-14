//
//  CreateNewAccountViewController.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 14/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit

class CreateNewAccountViewController: UIViewController {

    @IBOutlet weak var fourthField: UITextField!
    @IBOutlet weak var thirdField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    var phoneNumber = ""
    
    convenience init(phoneNumber: String) {
        self.init(nibName: "VerifyPhoneViewController", bundle: Bundle(identifier: "org.humanid.HumanIDSDK"))
        
        self.phoneNumber = phoneNumber
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneLabel.text = "Plese enter the 4-digit code you received as SMS to \(phoneNumber)"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resendCodeAction(_ sender: Any) {
        
    }
    
    @IBAction func tryDifferentNumberAction(_ sender: Any) {
        
    }
}
