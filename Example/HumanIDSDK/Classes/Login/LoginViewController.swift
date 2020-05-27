import UIKit
import HumanIDSDK

class LoginViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!

    private let displayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    private let applicationLogo = "Logo"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = displayName

        btnLogin.layer.cornerRadius = 8
        btnLogin.clipsToBounds = true
    }

    @IBAction func didLogin(_ sender: Any) {
        HumanIDSDK.shared.verify(view: self, name: displayName, image: applicationLogo)
    }
}

extension LoginViewController: VerifyDelegate {

    func register(with token: String) {
        guard let window = UIApplication.shared.keyWindow else { return }
        Cache.shared.setToken(with: token)

        let rootVC = HomeViewController()
        window.rootViewController = UINavigationController(rootViewController: rootVC)
    }
}
