//
//  AddEmailViewController.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 15/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit

class AddEmailViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    convenience init(clientImage: UIImage, clientName: String) {
        self.init(nibName: "AddEmailViewController", bundle: Bundle(identifier: "org.humanid.HumanIDSDK"))
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        saveButton.backgroundColor = UIColor(red: 84.7/100, green: 84.7/100, blue: 84.7/100, alpha: 1.0)
        saveButton.layer.cornerRadius = 5
        saveButton.clipsToBounds = true

    }
    
    @IBAction func emailFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        
        validateEmail(email: text)
    }
    
    private func validateEmail(email: String) {
        if email.isValidEmail() {
            saveButton.isEnabled = true
            saveButton.backgroundColor = UIColor(red: 0.8/100, green: 23.1/100, blue: 27.6/100, alpha: 1.0)
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = UIColor(red: 84.7/100, green: 84.7/100, blue: 84.7/100, alpha: 1.0)
        }
    }
    
    @IBAction func skipButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
    }
}

