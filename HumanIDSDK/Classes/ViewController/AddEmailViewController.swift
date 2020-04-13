import UIKit

public enum ConfirmEmailType {
    case newAccount
    case confirmAccount
}

class AddEmailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var confirmTitleLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    var screenType: ConfirmEmailType = .newAccount

    convenience init(type: ConfirmEmailType) {
        self.init(nibName: "AddEmailViewController", bundle: Bundle(identifier: "org.humanid.HumanIDSDK"))
        self.screenType = type
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    @IBAction func emailFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }

        validateEmail(email: text)
    }

    @IBAction func skipButtonAction(_ sender: Any) {
    }

    @IBAction func saveButtonAction(_ sender: Any) {
    }

    func configureView() {
        saveButton.isEnabled = false
        saveButton.backgroundColor = UIColor(red: 84.7/100, green: 84.7/100, blue: 84.7/100, alpha: 1.0)
        saveButton.layer.cornerRadius = 5
        saveButton.clipsToBounds = true

        switch screenType {
        case .newAccount:
            confirmTitleLabel.text = "For Your Security:"
            descriptionLabel.text = "Please enter your email address to recover access in case you lose your phone number. Ensure to enter an address you can access and remember! Only a non-readable encryption will be saved!"
        case .confirmAccount:
            confirmTitleLabel.text = "Last Step - For Your Security:"
            descriptionLabel.text = "To make sure we got the right account, please type your email address: "
        }
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
}
