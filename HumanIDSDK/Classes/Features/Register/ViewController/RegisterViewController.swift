class RegisterViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pinContainerView: UIView!
    @IBOutlet weak var humanIdTnc: UILabel!
    @IBOutlet weak var verificationInfo: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    var phoneNumber = ""
    var countryCode = ""

    convenience init(phoneNumber: String, countryCode: String) {
        self.init(nibName: "RegisterViewController", bundle: Bundle.humanID)
        self.phoneNumber = phoneNumber
        self.countryCode = countryCode
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
    }

    @objc func viewDidShowTnc(_ sender: UITapGestureRecognizer) {
    }

    @objc func viewDidResendCode(_ sender: UITapGestureRecognizer) {
    }

    @objc func updateTimer() {
    }
}
