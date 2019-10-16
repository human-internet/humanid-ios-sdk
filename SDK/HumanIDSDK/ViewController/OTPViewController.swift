//
//  OTPViewController.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 14/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit

public enum OTPType {
    case newAccount
    case newDevice
}

class OTPViewController: UIViewController {

    
    @IBOutlet weak var tryDifferentButton: UIButton!
    @IBOutlet weak var otpDescriptionLabel: UILabel!
    @IBOutlet weak var otpTitleLabel: UILabel!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var phoneLabel: UILabel!
    var phoneNumber = ""
    var otpType: OTPType = .newAccount
    
    convenience init(otpType: OTPType, phoneNumber: String = "") {
        self.init(nibName: "OTPViewController", bundle: Bundle.humanID)
        
        self.phoneNumber = phoneNumber
        self.otpType = otpType
    }
    
    lazy var inputV: OTPCodeView = {
        let f = UIFont.boldSystemFont(ofSize: 16)
        let c = OTPCodeView(numberOfPin: 4, inputColor: .clear, font: f, boxSize: CGSize(width: 44, height: 44), textColor: .black, spacing: 14, activeFieldColor: .clear, backgroundClr: .clear)
        c.delegate = self
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otpView.addSubview(inputV)
        configureView()
        
        inputV.anchorTo(top: otpView.topAnchor, leading: otpView.leadingAnchor, bottom: nil, trailing: otpView.trailingAnchor)
        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        switch otpType {
        case .newAccount:
            otpDescriptionLabel.text = "Welcome to humanID - the private & non-profit Sign In. Register now by securely confirming your phone number. It will never be saved to humanID or partner platforms."
            otpTitleLabel.text = "Creating a new Account"
            phoneLabel.text = "Plese enter the 4-digit code you received as SMS to \(phoneNumber)"
            tryDifferentButton.setTitle("Try different number", for: .normal)

        case .newDevice:
            otpDescriptionLabel.text = "We don’t recognize your device -\nplease verify your number"
            otpTitleLabel.text = "New Device"
            phoneLabel.text = "Plese enter the 4-digit code you received as SMS"
            tryDifferentButton.setTitle("Call me instead", for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputV.becomeFirstResponder()
    }
    
    @IBAction func resendCodeAction(_ sender: Any) {
        
    }
    
    @IBAction func tryDifferentNumberAction(_ sender: Any) {
        
    }
}

extension OTPViewController: OTPCodeViewDelegate {
    func didFinishInput(_ inputView: OTPCodeView, didFinishWith text: String) {
        print(text)
    }
}
