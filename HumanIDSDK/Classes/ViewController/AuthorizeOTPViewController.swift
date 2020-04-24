import UIKit
import VKPinCodeView

protocol AuthorizeOTPDelegate {

    func viewDidDismiss(token: String)
}

class AuthorizeOTPViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pinContainerView: UIView!
    @IBOutlet weak var humanIdTnc: UILabel!
    @IBOutlet weak var verificationInfo: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    var timer: Timer?
    var timerTap: UITapGestureRecognizer?

    var phoneNumber = ""
    var countryCode = ""
    var seconds = 30

    var delegate: AuthorizeOTPDelegate?

    lazy var pinView: VKPinCodeView = {
        let pinView = VKPinCodeView()
        pinView.translatesAutoresizingMaskIntoConstraints = false
        pinView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pinView.onSettingStyle = { UnderlineStyle() }
        pinView.becomeFirstResponder()

        pinView.onComplete = { code, _ in
            self.userRegistration(verificationCode: code)
        }

        return pinView
    }()

    convenience init(phoneNumber: String, countryCode: String) {
        self.init(nibName: "AuthorizeOTPViewController", bundle: Bundle.humanID)
        self.phoneNumber = phoneNumber
        self.countryCode = countryCode
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupListener()
        setupTimer()
    }

    func configureViews() {
        loadingView.isHidden = true

        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        pinContainerView.addSubview(pinView)
        pinView.leadingAnchor.constraint(equalTo: pinContainerView.leadingAnchor, constant: 40).isActive = true
        pinView.trailingAnchor.constraint(equalTo: pinContainerView.trailingAnchor, constant: -40).isActive = true
        pinView.centerYAnchor.constraint(equalTo: pinContainerView.centerYAnchor).isActive = true

        verificationInfo.text = "We just sent a text to +\(countryCode)\(phoneNumber). We will not save or forward this number after the verification"
    }

    func setupListener() {
        let tncTap = UITapGestureRecognizer(target: self, action: #selector(self.viewDidShowTnc(_ :)))
        humanIdTnc.isUserInteractionEnabled = true
        humanIdTnc.addGestureRecognizer(tncTap)

        timerTap = UITapGestureRecognizer(target: self, action: #selector(self.viewDidResendCode(_:)))
    }

    func setupTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }

    @objc func viewDidShowTnc(_ sender: UITapGestureRecognizer) {
        print("Show TnC...")
    }

    @objc func viewDidResendCode(_ sender: UITapGestureRecognizer) {
        resendCode()
    }

    @objc func updateTimer() {
        seconds -= 1

        switch seconds {
        case 0:
            invalidateTimer()
            resetTimerLabel()
        default:
            let timer = timeString(time: TimeInterval(seconds))
            timerLabel.text = "Resend code in \(timer)"
            timerLabel.isUserInteractionEnabled = false
            timerLabel.removeGestureRecognizer(timerTap!)
        }
    }

    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format: "%02i : %02i", minutes, seconds)
    }

    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func resetTimerLabel() {
        timerLabel.text = "Resend code"
        timerLabel.isUserInteractionEnabled = true
        timerLabel.addGestureRecognizer(timerTap!)
    }

    // MARK: - Call API userRegistration
    private func userRegistration(verificationCode: String) {
        invalidateTimer()
        showLoading()

        HumanIDSDK.shared.userRegistration(phoneNumber: phoneNumber, countryCode: countryCode, verificationCode: verificationCode, completion: { (_, response) in
            DispatchQueue.main.async {
                self.hideLoading()

                guard let data = response.data?.result else {
                    self.resetTimerLabel()

                    let alertController = UIAlertController(title: nil, message: response.message, preferredStyle: .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .default)
                    alertController.addAction(closeAction)

                    self.present(alertController, animated: true)
                    return
                }

                self.dismiss(animated: true)
                self.delegate?.viewDidDismiss(token: data.exchangeToken)
            }
        })
    }

    // MARK: - Re-Call API verifyPhone
    private func resendCode() {
        seconds = 30
        setupTimer()
        pinView.resetCode()
        showLoading()

        HumanIDSDK.shared.verifyPhone(phoneNumber: phoneNumber, countryCode: countryCode, completion: { (_, response) in
            DispatchQueue.main.async {
                self.hideLoading()

                guard let _ = response.data else {
                    let alertController = UIAlertController(title: nil, message: response.message, preferredStyle: .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .default)
                    alertController.addAction(closeAction)

                    self.present(alertController, animated: true)
                    return
                }
            }
        })
    }

    private func showLoading() {
        timerLabel.isHidden = true
        loadingView.isHidden = false
    }

    private func hideLoading() {
        timerLabel.isHidden = false
        loadingView.isHidden = true
    }
}
