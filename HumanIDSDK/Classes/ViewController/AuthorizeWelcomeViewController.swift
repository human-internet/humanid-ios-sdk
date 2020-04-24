import UIKit
import FlagPhoneNumber

public protocol AuthorizeDelegate {

    func viewDidSuccess(token: String)
}

class AuthorizeWelcomeViewController: UIViewController {

    @IBOutlet weak var phoneContainerView: UIView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var appLogo: UIImageView!
    @IBOutlet weak var welcomeMessage: UILabel!
    @IBOutlet weak var welcomeDesc: UILabel!
    @IBOutlet weak var welcomeTnc: UILabel!
    @IBOutlet weak var cancelLabel: UIButton!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)

    var appName = ""
    var appImage = ""

    var delegate: AuthorizeDelegate?

    lazy var phoneNumberTextField: FPNTextField = {
        let phoneNumberTextField = FPNTextField(frame: CGRect(x: 0, y: 0, width: phoneContainerView.bounds.width - 16, height: 30))
        phoneNumberTextField.setFlag(countryCode: .ID)
        phoneNumberTextField.font = UIFont.font(type: .titiliumWebRegular, size: 14)
        phoneNumberTextField.textColor = .white
        phoneNumberTextField.placeholder = "Your phone number"
        phoneNumberTextField.tintColor = .white

        return phoneNumberTextField
    }()

    convenience init(appName: String, appImage: String) {
        self.init(nibName: "AuthorizeWelcomeViewController", bundle: Bundle.humanID)
        self.appName = appName
        self.appImage = appImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupListener()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func configureViews() {
        view.backgroundColor = .twilightBlue

        loadingView.isHidden = true

        phoneContainerView.addSubview(phoneNumberTextField)

        enterButton.backgroundColor = .lightMusrad
        enterButton.tintColor = .twilightBlue
        enterButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)

        appLogo.image = UIImage(named: appImage)

        welcomeMessage.text = "Welcome to \(appName)"
        welcomeDesc.text = "Verify your phone number to connect anonymously with \(appName)"
        welcomeTnc.text = "OTP verification is managed by an independent 3rd party. Number & fingerprints are never visible to humanID or \(appName). Learn More"
    }

    func setupListener() {
        let tncTap = UITapGestureRecognizer(target: self, action: #selector(self.viewDidShowTnc(_ :)))
        welcomeTnc.isUserInteractionEnabled = true
        welcomeTnc.addGestureRecognizer(tncTap)
    }

    @IBAction func showOTPModal(_ sender: Any) {
        guard
            let phoneNumber = phoneNumberTextField.getRawPhoneNumber(),
            let countryCode = phoneNumberTextField.selectedCountry?.phoneCode.replacingOccurrences(of: "+", with: "")
            else { return }

        // MARK: - Call API verifyPhone
        showLoading()

        HumanIDSDK.shared.verifyPhone(phoneNumber: phoneNumber, countryCode: countryCode) { (_, response) in
            DispatchQueue.main.async {
                self.hideLoading()

                guard let _ = response.data else {
                    let alertController = UIAlertController(title: nil, message: response.message, preferredStyle: .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .default)
                    alertController.addAction(closeAction)

                    self.present(alertController, animated: true)
                    return
                }

                let vc = AuthorizeOTPViewController(phoneNumber: phoneNumber, countryCode: countryCode)
                vc.delegate = self

                if #available(iOS 13.0, *) {
                    vc.modalPresentationStyle = .automatic
                } else {
                    vc.modalPresentationStyle = .formSheet
                }

                self.view.endEditing(true)
                self.present(vc, animated: true, completion: nil)
            }
        }
    }

    @IBAction func viewDidDismiss(_ sender: Any) {
        dismiss(animated: true)
    }

    @objc func viewDidShowTnc(_ sender: UITapGestureRecognizer) {
        print("Show TnC...")
    }

    private func showLoading() {
        enterButton.isEnabled = false
        cancelLabel.isHidden = true
        loadingView.isHidden = false
    }

    private func hideLoading() {
        enterButton.isEnabled = true
        cancelLabel.isHidden = false
        loadingView.isHidden = true
    }
}

// MARK: - AuthorizeOTP Delegate
extension AuthorizeWelcomeViewController: AuthorizeOTPDelegate {

    func viewDidDismiss(token: String) {
        dismiss(animated: true)
        delegate?.viewDidSuccess(token: token)
    }
}
