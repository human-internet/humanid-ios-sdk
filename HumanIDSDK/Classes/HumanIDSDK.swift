open class HumanIDSDK {

    public static let shared = HumanIDSDK()

    private init() {}

    open func configure(clientID: String, clientSecret: String) {
        _ = KeyChain.isStoreSuccess(key: .clientID, value: clientID)
        _ = KeyChain.isStoreSuccess(key: .clientSecret, value: clientSecret)

        // MARK: - Retrieve current deviceID automatically
        guard let _ = KeyChain.retrieves(key: .deviceID) else {
            let deviceID = UIDevice.current.identifierForVendor!.uuidString
            _ = KeyChain.isStoreSuccess(key: .deviceID, value: deviceID)

            return
        }
    }

    open func requestOtp(view viewController: UIViewController, name appName: String, image appImage: String) {
        // MARK: - Open humanID requestOtp page
        let requestOtpVC = Injector.shared.resolver.resolve(RequestOTPViewController.self)!
        requestOtpVC.appName = appName
        requestOtpVC.appImage = appImage
        requestOtpVC.delegate = viewController as? RequestOTPDelegate

        viewController.present(requestOtpVC, animated: true)
    }
}
