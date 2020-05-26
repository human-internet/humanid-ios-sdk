import FlagPhoneNumber

public protocol VerifyDelegate {

    func register(with token: String)
}

internal class VerifyViewController: UIViewController {

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

    var delegate: VerifyDelegate?
    var input: VerifyInteractorInput?
    var router: VerifyRoutingLogic?
    var request: Verify.Request?

    lazy var phoneNumberTextField: FPNTextField = {
        let phoneNumberTextField = FPNTextField(frame: CGRect(x: 0, y: 0, width: phoneContainerView.bounds.width - 16, height: 30))
        phoneNumberTextField.setFlag(countryCode: .ID)
        phoneNumberTextField.font = UIFont.font(type: .titiliumWebRegular, size: 14)
        phoneNumberTextField.textColor = .white
        phoneNumberTextField.placeholder = "Your phone number"
        phoneNumberTextField.tintColor = .white

        return phoneNumberTextField
    }()

    convenience init() {
        self.init(nibName: "VerifyViewController", bundle: Bundle.humanID)
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
            let countryCode = phoneNumberTextField.selectedCountry?.phoneCode.replacingOccurrences(of: "+", with: ""),
            let phone = phoneNumberTextField.getRawPhoneNumber() else { return }

        let appId = KeyChain.retrieveString(key: .appIDKey) ?? ""
        let appSecret = KeyChain.retrieveString(key: .appSecretKey) ?? ""

        self.request = .init(
            countryCode: countryCode,
            phone: phone,
            appId: appId,
            appSecret: appSecret
        )
        input?.verify(with: self.request!)
    }

    @IBAction func viewDidDismiss(_ sender: Any) {
        dismiss(animated: true)
    }

    @objc func viewDidShowTnc(_ sender: UITapGestureRecognizer) {
        router?.openTnc()
    }
}

// MARK: - Presenter Delegate
extension VerifyViewController: VerifyPresenterOutput {

    func showLoading() {
        enterButton.isEnabled = false
        cancelLabel.isHidden = true
        loadingView.isHidden = false
    }

    func hideLoading() {
        enterButton.isEnabled = true
        cancelLabel.isHidden = false
        loadingView.isHidden = true
    }

    func success() {
        view.endEditing(true)
        router?.pushRegisterVC(with: self.request!)
    }

    func error(with message: String) {
        alertVC(with: message)
    }
}

// MARK: - Register Delegate
extension VerifyViewController: RegisterDelegate {

    func register(with viewModel: Register.ViewModel) {
        dismiss(animated: true) {
            self.delegate?.register(with: viewModel.token)
        }
    }
}
