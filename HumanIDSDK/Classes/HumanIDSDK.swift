open class HumanIDSDK {

    internal static var isSandbox = false

    public static let shared = HumanIDSDK()

    private init() {}

    open func configure(clientID: String, clientSecret: String, isSandbox: Bool = false) {
        _ = KeyChain.isStoreSuccess(key: .clientID, value: clientID)
        _ = KeyChain.isStoreSuccess(key: .clientSecret, value: clientSecret)

        /// Sandbox server flag
        HumanIDSDK.isSandbox = isSandbox

        /// Retrieve current deviceID automatically
        guard let _ = KeyChain.retrieves(key: .deviceID) else {
            let deviceID = UIDevice.current.identifierForVendor!.uuidString
            _ = KeyChain.isStoreSuccess(key: .deviceID, value: deviceID)

            return
        }
    }

    open func requestOtp(name appName: String, image appImage: String) {
        /// Open humanID main page
        let root = UIApplication.topViewController()

        let controller = Injector.shared.resolve(MainViewController.self)!
        controller.modalPresentationStyle = .overFullScreen
        controller.root = root
        controller.clientName = appName
        controller.clientLogo = appImage

        root?.present(controller, animated: true)
    }
}
