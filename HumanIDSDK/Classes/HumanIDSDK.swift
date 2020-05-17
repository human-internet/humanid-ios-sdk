open class HumanIDSDK {

    public static let shared = HumanIDSDK()

    private init() {}

    open func configure(appID: String, appSecret: String) {
        // MARK: - Retrieve current deviceID automatically
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()

        _ = KeyChain.isStoreSuccess(key: .appIDKey, value: appID)
        _ = KeyChain.isStoreSuccess(key: .appSecretKey, value: appSecret)
        _ = KeyChain.isStoreSuccess(key: .deviceID, value: deviceID)
    }

    open func verify(view viewController: UIViewController, name appName: String, image appImage: String) {
        let verifyVC = HumanIDRouter.shared.resolvedVerifyVC(name: appName, image: appImage)
        verifyVC.delegate = viewController as? VerifyDelegate

        viewController.present(verifyVC, animated: true)
    }

    open func revoke() {
        HumanIDRouter.shared.resolvedRevoke()
    }
}
