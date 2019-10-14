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
        navigationController?.present(HumanIDSDK.shared.getCreateNewAccountViewController(phoneNumber: "+62827182378"), animated: true, completion: nil)
    }
    
    @IBAction func loginWithHumanIDAction(_ sender: Any) {
        navigationController?.present(HumanIDSDK.shared.getVerifyPhoneNumberViewController(clientImage: UIImage(named: "Antena")!, clientName: "Demo APP 2"), animated: true, completion: nil)
    }
    
    @IBAction func loginWithGoogleAction(_ sender: Any) {
        print("google")
    }
    
}
