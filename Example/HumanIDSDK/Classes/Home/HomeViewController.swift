import UIKit
import HumanIDSDK

class HomeViewController: UIViewController {

    @IBOutlet weak var btnLogout: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"

        btnLogout.layer.cornerRadius = 8
        btnLogout.clipsToBounds = true
    }

    @IBAction func didLogout(_ sender: Any) {
        // TODO: - Implement logout sdk
    }
}
