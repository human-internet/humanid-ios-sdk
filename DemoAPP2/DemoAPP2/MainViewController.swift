//
//  MainViewController.swift
//  DemoAPP2
//
//  Created by fanni suyuti on 09/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit
import HumanIDSDK

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        // Do any additional setup after loading the view.
    }

    @IBAction func loginWithFacebookAction(_ sender: Any) {
        navigationController?.present(HumanIDSDK.shared.getOTPViewController(otpType: .newDevice, phoneNumber: "+62827182378"), animated: true, completion: nil)
    }
    
    @IBAction func loginWithHumanIDAction(_ sender: Any) {
        let vc = HumanIDSDK.shared.getLoginViewController(clientName: "Demo APP 2")
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginWithGoogleAction(_ sender: Any) {
        
        let vc = HumanIDSDK.shared.getEmailConfirmationViewController(email: "john@email.com", clientName: "Demo APP 2")
        vc.modalPresentationStyle = .overCurrentContext
        
        present(vc, animated: true, completion: nil)
    }
    
}
