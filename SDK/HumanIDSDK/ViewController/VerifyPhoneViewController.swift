//
//  VerifyPhoneViewController.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 07/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit

class VerifyPhoneViewController: UIViewController {
    
    @IBOutlet weak var downloadView: UIView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var countryCodeField: UITextField!
    @IBOutlet weak var clientImageView: UIImageView!
    @IBOutlet weak var verifyHeaderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    
    fileprivate let pickerView = ToolbarPickerView()
    
    let countries : [Country] = Array<Country>.countries!
    
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
        
        countryCodeField.inputView = pickerView
        countryCodeField.inputAccessoryView = pickerView.toolbar
        
        countryCodeField.delegate = self
        phoneNumberField.delegate = self
        
        enterButton.isEnabled = false
        enterButton.backgroundColor = UIColor(red: 84.7/100, green: 84.7/100, blue: 84.7/100, alpha: 1.0)
        enterButton.layer.cornerRadius = 5
        enterButton.clipsToBounds = true
        
        downloadView.layer.cornerRadius = 8
        downloadView.clipsToBounds = true
        
        let local = Locale.current.regionCode
        
        countryCodeField.text = countries.filter({ country -> Bool in
            return country.code == local
            }).first?.dialCode ?? ""
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.toolbarDelegate = self
        
        pickerView.reloadAllComponents()
        
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
        print("enter")
    }
    
    @IBAction func phoneNumberFieldChanged(_ sender: UITextField) {
        validatePhoneNumber()
        
    }
    
    @IBAction func transferPhoneNumberButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func countryCodeFieldChanged(_ sender: UITextField) {
        validatePhoneNumber()
    }
    
    private func validatePhoneNumber() {
        if countryCodeField.text != "" && phoneNumberField.text!.count >= 5 {
            enterButton.isEnabled = true
            enterButton.backgroundColor = UIColor(red: 0.8/100, green: 23.1/100, blue: 27.6/100, alpha: 1.0)
        } else {
            enterButton.isEnabled = false
            enterButton.backgroundColor = UIColor(red: 84.7/100, green: 84.7/100, blue: 84.7/100, alpha: 1.0)
        }
    }
    
}

extension VerifyPhoneViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(countries[row].name) \(countries[row].dialCode)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryCodeField.text = countries[row].dialCode
    }
}

extension VerifyPhoneViewController: ToolbarPickerViewDelegate {

    func didTapDone() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        pickerView.selectRow(row, inComponent: 0, animated: false)
        countryCodeField.text = countries[row].dialCode
        countryCodeField.resignFirstResponder()
    }

    func didTapCancel() {
        countryCodeField.resignFirstResponder()
    }
}

extension VerifyPhoneViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == countryCodeField {
            return false
        }
        
        if string.count == 0 {
            return true
        }
        
        let numset = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: numset)
        let numberFiltered = compSepByCharInSet.joined(separator: "")

        if string == numberFiltered {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            return updatedText.count <= 14
        } else {
            return false
        }
    }
}
