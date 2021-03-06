import UIKit
import HumanIDSDK

final class LoginViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!

    private let displayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String

    override func viewDidLoad() {
        title = displayName

        btnLogin.layer.cornerRadius = 8
        btnLogin.clipsToBounds = true
    }

    @IBAction func didLogin(_ sender: Any) {
        // MARK: - Retrieve HumanIDSDK appID and appSecret
        let clientID = "MOBILE_VMLS7FS4PVEEKTRWF22379"
        let clientSecret = "Qk1CC.H0ou9f0D5yhVNyWCeo1MKyg7-0D7fBndUfo7TtUFOdmDWLO9_x5m70ROmt"
        HumanIDSDK.shared.webLogin(with: clientID, and: clientSecret)
    }
}

extension LoginViewController: WebLoginDelegate {

    func login(with token: String) {
        Cache.shared.setToken(with: token)

        let rootVC = HomeViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        UIApplication.shared.windows.filter { window in window.isKeyWindow }.first?.rootViewController = navVC
    }
}
