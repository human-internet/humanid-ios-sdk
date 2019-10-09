//
//  VerifyPhoneViewController.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 07/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit

class VerifyPhoneViewController: UIViewController {
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var countryCodeField: UITextField!
    @IBOutlet weak var clientImageView: UIImageView!
    @IBOutlet weak var verifyHeaderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    
    var clientImage = UIImage()
    var clientName = ""
    convenience init(clientImage: UIImage, clientName: String) {
        self.init(nibName: "VerifyPhoneViewController", bundle: Bundle(identifier: "org.humanid.HumanIDSDK"))
        
        self.clientImage = clientImage
        self.clientName = clientName
    }
    
    var descriptionText = ""
    let linkText = "Learn More"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionText = "OTP Verification is handled by independent 3rd party. Number & fingerprints are never visible to humanID or \(clientName). Learn More"
        
        clientImageView.image = clientImage
        verifyHeaderLabel.text = "Verify your phone number to connect anonymously with \(clientName)"
        // Do any additional setup after loading the view.
       let formattedText = String.atributedFormat(strings: [linkText],
                                           boldFont: UIFont.boldSystemFont(ofSize: 15),
                                           boldColor: UIColor.blue,
                                           inString: descriptionText,
                                           font: UIFont.systemFont(ofSize: 15),
                                           color: UIColor.black)
       descriptionLabel.attributedText = formattedText
        
       let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel))
       descriptionLabel.addGestureRecognizer(tap)
       descriptionLabel.isUserInteractionEnabled = true
    }
    
    @objc func handleTapOnLabel(gesture: UITapGestureRecognizer) {
        let termString = descriptionText as NSString
        let termRange = termString.range(of: linkText)

        let tapLocation = gesture.location(in: descriptionLabel)
        let index = descriptionLabel.attributedTextIndex(point: tapLocation)

        if textContain(termRange, index) == true {
            learnMoreAboutHumanID()
            return
        }
    }
    
    func learnMoreAboutHumanID() {
        //TODO: implement link to learn more about humanid
        print("clicked")
    }
    
    func textContain(_ range: NSRange,_ index: Int) -> Bool {
        return index > range.location && index < range.location + range.length
    }

    @IBAction func downloadButtonAction(_ sender: Any) {
        //TODO: implement download button
    }
    
    @IBAction func enterButtonAction(_ sender: Any) {
        //TODO: implement verifiying process
    }
}
