import WebKit

internal final class WebLoginViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    var root: UIViewController!
    var input: WebLoginInteractorInput!

    convenience init() {
        self.init(nibName: "WebLoginViewController", bundle: Bundle.humanID)
    }

    override func viewDidLoad() {
        configureViews()
    }

    func configureViews() {
        loadingView.isHidden = true

        // TODO: - Refactoring this later
        webLogin()
    }

    private func webLogin() {
        let clientId = KeyChain.retrieves(key: .clientID) ?? ""
        let clientSecret = KeyChain.retrieves(key: .clientSecret) ?? ""
        let header = BaseRequest(clientId: clientId, clientSecret: clientSecret)

        input.webLogin(with: header, and: .init(
            language: "en",
            priorityCodes: ["US", "DE", "FR"])
        )
    }
}

// MARK: - Presenter Delegate
extension WebLoginViewController: WebLoginPresenterOutput {

    func showLoading() {
        loadingView.isHidden = false
    }

    func hideLoading() {
        loadingView.isHidden = true
    }

    func success(with url: String) {
        // TODO: - Implement show web view
        print("Open \(url)")
    }

    func error(with message: String) {
        alertVC(with: message)
    }
}
