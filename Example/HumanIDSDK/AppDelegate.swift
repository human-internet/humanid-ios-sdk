import UIKit
import HumanIDSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: - Retrieve HumanIDSDK appID and appSecret
        let appID = "DEMO_APP"
        let appSecret = "2ee4300fd136ed6796a6a507de7c1f49aecd4a11663352fe54e54403c32bd6a0"
        HumanIDSDK.shared.configure(appID: appID, appSecret: appSecret)

        let rootVC = getRootVC()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: rootVC)
        window?.makeKeyAndVisible()

        return true
    }

    private func getRootVC() -> UIViewController {
        guard let _ = Cache.shared.getToken() else {
            return LoginViewController()
        }

        return HomeViewController()
    }
}
