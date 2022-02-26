open class HumanIDSDKV2 {

    internal static var isStaging = false

    public static let shared = HumanIDSDKV2()

    private init() {}

    open func webLogin(with clientID: String, and clientSecret: String, isTesting isStaging: Bool = false) {
        _ = KeyChain.isStoreSuccess(key: .clientID, value: clientID)
        _ = KeyChain.isStoreSuccess(key: .clientSecret, value: clientSecret)

        /// Staging server flag
        HumanIDSDKV2.isStaging = isStaging

        let controller = Injector.shared.resolve(WebLoginViewController.self)!
        controller.modalPresentationStyle = .overFullScreen

        let navigation = UINavigationController(rootViewController: controller)
        let root = UIApplication.topViewController()
        root?.present(navigation, animated: true)
    }
}
