import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var btnLogout: UIButton!

    override func viewDidLoad() {
        title = "Home"

        btnLogout.layer.cornerRadius = 8
        btnLogout.clipsToBounds = true
    }

    @IBAction func didLogout(_ sender: Any) {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }.first?.windows
            .filter { $0.isKeyWindow }.first

        Cache.shared.clear()

        let rootVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        keyWindow?.rootViewController = navVC
    }
}
