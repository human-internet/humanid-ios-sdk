//
//  LoginViewController.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 16/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    @IBOutlet weak var secondDescriptionView: UIView!
    @IBOutlet weak var loginWithAnotherNumberView: UIView!
    @IBOutlet weak var loginWithAnotherNumberButton: UIButton!
    @IBOutlet weak var learnMoreView: UIView!
    
    var clientName = ""
    var attempt = 0
    
    convenience init(clientName: String) {
        self.init(nibName: "LoginViewController", bundle: Bundle.humanID)
        
        self.clientName = clientName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = "Please use your finger to anonymously sign in to \(clientName) using humanID"
        loginWithAnotherNumberButton.layer.cornerRadius = 5
        containerView.layer.cornerRadius = 10
        loginWithAnotherNumberButton.titleLabel?.textAlignment = .center
        
        secondDescriptionLabel.text = "Your number & fingerprints can never be accessed by humanID or \(clientName).  We only sees a non-revertable, yet unique encryption to verify you to \(clientName). Learn More"
        configureView()
        
    }
    
    @IBAction func authWithTouchID(_ sender: Any) {

        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with HumanID"

            context.localizedFallbackTitle = ""
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                (success, error) in

                DispatchQueue.main.async {
                    if success {
                        self.showAlertController("Touch ID Authentication Succeeded")
                    }
                    else {
                        
                        self.configureView(isTooManyAttempt: true)
                    }
                }
            }
        } else {
            showAlertController("Touch ID not available")
        }
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func configureView(isTooManyAttempt: Bool = false) {
        secondDescriptionView.isHidden = isTooManyAttempt
        loginWithAnotherNumberView.isHidden = !isTooManyAttempt
        learnMoreView.isHidden = isTooManyAttempt
    }
    
    @IBAction func learnMoreButtonAction(_ sender: Any) {
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
    }
    
    @IBAction func loginWithAnotherNumberButtonAction(_ sender: Any) {
    }
    
    
}
