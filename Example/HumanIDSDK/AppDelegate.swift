import UIKit
import HumanIDSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: - Retrieve HumanIDSDK appID and appSecret
        let appID = "DEMO_APP"
        let appSecret = "2ee4300fd136ed6796a6a507de7c1f49aecd4a11663352fe54e54403c32bd6a0"

        HumanIDSDK.shared.config(appID: appID, appSecret: appSecret)

        let rootVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: rootVC)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()

        return true
    }
}
