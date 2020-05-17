import UIKit
import HumanIDSDK

class LoginViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Application"

        btnLogin.layer.cornerRadius = 8
        btnLogin.clipsToBounds = true
    }

    @IBAction func didLogin(_ sender: Any) {
        HumanIDSDK.shared.verify(view: self, name: "My Application", image: "logo_mdb")
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
