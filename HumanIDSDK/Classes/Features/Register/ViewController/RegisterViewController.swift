import VKPinCodeView

internal protocol RegisterDelegate {

    func register(with viewModel: Register.ViewModel)
}

internal class RegisterViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pinContainerView: UIView!
    @IBOutlet weak var humanIdTnc: UILabel!
    @IBOutlet weak var verificationInfo: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    var timer: Timer?
    var timerTap: UITapGestureRecognizer?

    var countryCode = ""
    var phoneNumber = ""
    var seconds = 30

    var delegate: RegisterDelegate?
    var input: RegisterInteractorInput?
    var router: RegisterRoutingLogic?
    var requestVerify: Verify.Request?
    var requestRegister: Register.Request?

    lazy var pinView: VKPinCodeView = {
        let pinView = VKPinCodeView()
        pinView.translatesAutoresizingMaskIntoConstraints = false
        pinView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pinView.onSettingStyle = { UnderlineStyle() }
        pinView.becomeFirstResponder()

        pinView.onComplete = { code, _ in
            self.register(verificationCode: code)
        }

        return pinView
    }()

    convenience init() {
        self.init(nibName: "RegisterViewController", bundle: Bundle.humanID)
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
        view.endEditing(true)
    }

    @objc func viewDidShowTnc(_ sender: UITapGestureRecognizer) {
        router?.openTnc()
    }

    @objc func viewDidResendCode(_ sender: UITapGestureRecognizer) {
        seconds = 30
        setupTimer()
        pinView.resetCode()

        let appId = KeyChain.retrieveString(key: .appIDKey) ?? ""
        let appSecret = KeyChain.retrieveString(key: .appSecretKey) ?? ""

        self.requestVerify = .init(
            countryCode: self.countryCode,
            phone: self.phoneNumber,
            appId: appId,
            appSecret: appSecret
        )
        input?.verify(with: self.requestVerify!)
    }

    @objc func updateTimer() {
        seconds -= 1

        switch seconds {
        case 0:
            invalidateTimer()
            resetTimerLabel()
        default:
            let timer = TimeInterval(seconds).toMinutesSeconds()
            timerLabel.text = "Resend code in \(timer)"
            timerLabel.isUserInteractionEnabled = false
            timerLabel.removeGestureRecognizer(timerTap!)
        }
    }

    private func register(verificationCode: String) {
        invalidateTimer()

        let appId = KeyChain.retrieveString(key: .appIDKey) ?? ""
        let appSecret = KeyChain.retrieveString(key: .appSecretKey) ?? ""
        let deviceId = KeyChain.retrieveString(key: .deviceID) ?? ""

        self.requestRegister = .init(
            countryCode: self.countryCode,
            phone: self.phoneNumber,
            deviceId: deviceId,
            verificationCode: verificationCode,
            appId: appId,
            appSecret: appSecret
        )
        input?.register(with: self.requestRegister!)
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
}

// MARK: - Presenter Delegate
extension RegisterViewController: RegisterPresenterOutput {

    func showLoading() {
        timerLabel.isHidden = true
        loadingView.isHidden = false
    }

    func hideLoading() {
        timerLabel.isHidden = false
        loadingView.isHidden = true
    }

    func successRegister(with viewModel: Register.ViewModel) {
        dismiss(animated: true) {
            self.delegate?.register(with: viewModel)
        }
    }

    func errorRegister(with message: String) {
        resetTimerLabel()
        alertVC(with: message)
    }

    func errorVerify(with message: String) {
        alertVC(with: message)
    }
}
