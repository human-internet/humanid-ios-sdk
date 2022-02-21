open class HumanIDSDKV2 {

    internal static var isStaging = false

    public static let shared = HumanIDSDKV2()

    private init() {}

    open func webLogin(from target: UIViewController, with clientID: String, and clientSecret: String, staging isStaging: Bool = false) {
        _ = KeyChain.isStoreSuccess(key: .clientID, value: clientID)
        _ = KeyChain.isStoreSuccess(key: .clientSecret, value: clientSecret)

        /// Staging server flag
        HumanIDSDKV2.isStaging = isStaging

        let controller = Injector.shared.resolve(WebLoginViewController.self)!
        controller.modalPresentationStyle = .overFullScreen
        controller.root = target

        target.present(controller, animated: true)
    }
}
