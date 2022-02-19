import UIKit
import HumanIDSDK

final class LoginViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!

    private let displayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    private let applicationLogo = "Logo"

    override func viewDidLoad() {
        title = displayName

        btnLogin.layer.cornerRadius = 8
        btnLogin.clipsToBounds = true
    }

    @IBAction func didLogin(_ sender: Any) {
        HumanIDSDK.shared.requestOtp(from: self, name: displayName, image: applicationLogo)
    }
}

extension LoginViewController: RequestOTPDelegate {

    func login(with token: String) {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }.first?.windows
            .filter { $0.isKeyWindow }.first

        Cache.shared.setToken(with: token)

        let rootVC = HomeViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        keyWindow?.rootViewController = navVC
    }
}
