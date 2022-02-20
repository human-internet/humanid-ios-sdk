import UIKit
import HumanIDSDK

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let contoller = UINavigationController(rootViewController: getController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = contoller
        window?.makeKeyAndVisible()

        return true
    }

    private func getController() -> UIViewController {
        return Cache.shared.getToken() != nil ? HomeViewController() : LoginViewController()
    }
}
