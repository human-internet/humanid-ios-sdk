//
//  CreateNewAccountViewController.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 14/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit

class CreateNewAccountViewController: UIViewController {

    
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var phoneLabel: UILabel!
    var phoneNumber = ""
    
    convenience init(phoneNumber: String) {
        self.init(nibName: "CreateNewAccountViewController", bundle: Bundle(identifier: "org.humanid.HumanIDSDK"))
        
        self.phoneNumber = phoneNumber
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
        phoneLabel.text = "Plese enter the 4-digit code you received as SMS to \(phoneNumber)"
        inputV.anchorTo(top: otpView.topAnchor, leading: otpView.leadingAnchor, bottom: nil, trailing: otpView.trailingAnchor)
        // Do any additional setup after loading the view.
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

extension CreateNewAccountViewController: OTPCodeViewDelegate {
    func didFinishInput(_ inputView: OTPCodeView, didFinishWith text: String) {
        print(text)
    }
}
