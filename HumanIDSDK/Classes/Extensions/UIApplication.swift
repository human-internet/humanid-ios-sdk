internal extension UIApplication {

    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.windows.filter { window in window.isKeyWindow }.first?.rootViewController) -> UIViewController? {
        if let navigation = viewController as? UINavigationController {
            return topViewController(navigation.visibleViewController)
        }

        if let tab = viewController as? UITabBarController,
           let selected = tab.selectedViewController {
            return topViewController(selected)
        }

        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }

        return viewController
    }
}
