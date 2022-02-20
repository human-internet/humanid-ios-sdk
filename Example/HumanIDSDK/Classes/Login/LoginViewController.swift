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
        HumanIDSDKV2.shared.webLogin(from: self, with: clientID, and: clientSecret, staging: true)
    }
}
