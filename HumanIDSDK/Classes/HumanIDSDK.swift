open class HumanIDSDK {

    public static let shared = HumanIDSDK()

    private init() {}

    open func configure(appID: String, appSecret: String) {
        _ = KeyChain.isStoreSuccess(key: .appIDKey, value: appID)
        _ = KeyChain.isStoreSuccess(key: .appSecretKey, value: appSecret)

        // MARK: - Retrieve current deviceID automatically
        guard let _ = KeyChain.retrieves(key: .deviceID) else {
            let deviceID = UIDevice.current.identifierForVendor!.uuidString
            _ = KeyChain.isStoreSuccess(key: .deviceID, value: deviceID)

            return
        }
    }

    open func requestOtp(view viewController: UIViewController, name appName: String, image appImage: String) {
        // MARK: - Open humanID verification page
        let requestOtpVC = Injector.shared.resolver.resolve(RequestOTPViewController.self)!
        requestOtpVC.appName = appName
        requestOtpVC.appImage = appImage
        requestOtpVC.delegate = viewController as? RequestOTPDelegate

        viewController.present(requestOtpVC, animated: true)
    }
}
