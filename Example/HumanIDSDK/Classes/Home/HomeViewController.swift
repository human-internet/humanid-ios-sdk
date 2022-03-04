import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var tokenLabel: UILabel!

    override func viewDidLoad() {
        title = "Home"

        btnLogout.layer.cornerRadius = 8
        btnLogout.clipsToBounds = true

        if let token = Cache.shared.getToken() {
            tokenLabel.text = "Your token is \(token)"
        }
    }

    @IBAction func didLogout(_ sender: Any) {
        Cache.shared.clear()

        let rootVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        UIApplication.shared.windows.filter { window in window.isKeyWindow }.first?.rootViewController = navVC
    }
}
