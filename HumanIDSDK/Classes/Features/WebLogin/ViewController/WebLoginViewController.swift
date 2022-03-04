import WebKit

public protocol WebLoginDelegate: AnyObject {

    func login(with token: String)
}

internal final class WebLoginViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    var header: BaseRequest!
    var request: WebLogin.Request!

    var input: WebLoginInteractorInput!

    var delegate: WebLoginDelegate?

    convenience init() {
        self.init(nibName: "WebLoginViewController", bundle: Bundle.humanID)
    }

    override func viewDidLoad() {
        configureViews()
        webLogin()
    }

    func configureViews() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.leftBarButtonItem = closeButton

        webView.navigationDelegate = self
        webView.configuration.websiteDataStore = .nonPersistent()

        loadingView.isHidden = true
    }

    func webLogin() {
        input.webLogin(with: header, and: request)
    }

    @objc private func close() {
        dismiss(animated: true)
    }
}

// MARK: - WKWebView Delegate
extension WebLoginViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        var action: WKNavigationActionPolicy?

        defer {
            decisionHandler(action ?? .allow)
        }

        if let requestUrl = navigationAction.request.url {
            let webUrl = requestUrl.absoluteString.lowercased()

            switch webUrl {
                case _ where webUrl.starts(with: "https://"):
                    action = .allow

                    break
                default:
                    guard let exchangeToken = webUrl.getQueryParameter(from: "et"), !exchangeToken.isEmpty else { return action = .none }
                    action = .cancel

                    dismiss(animated: true) {
                        self.delegate?.login(with: exchangeToken)
                    }

                    break
            }
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        input.hideLoading()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        input.hideLoading()

        alertVC(with: error.localizedDescription) { _ in
            self.dismiss(animated: true)
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        input.hideLoading()

        alertVC(with: error.localizedDescription) { _ in
            self.dismiss(animated: true)
        }
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
        webView.load(.init(url: .init(string: url)!))
    }

    func error(with message: String) {
        alertVC(with: message) { _ in
            self.dismiss(animated: true)
        }
    }
}
