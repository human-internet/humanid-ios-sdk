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
        HumanIDSDK.shared.authorize(view: self, name: "My Application", image: "logo_mdb")
    }
}

extension LoginViewController: AuthorizeDelegate {

    func viewDidSuccess(token: String, hash: String) {
        guard let window = UIApplication.shared.keyWindow else { return }

        let rootVC = HomeViewController()
        rootVC.exchangeToken = token
        rootVC.userHash = hash

        let navVC = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navVC
    }
}
