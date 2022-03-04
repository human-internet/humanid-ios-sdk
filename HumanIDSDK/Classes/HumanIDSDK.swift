open class HumanIDSDK {

    // FIXME: - Use this for development purpose!
    internal static var isStaging = true

    public static let shared = HumanIDSDK()

    private init() {}

    open func webLogin(with clientID: String, and clientSecret: String, language: String = "en", countries: [String] = ["US,UK"]) {
        let controller = Injector.shared.resolve(WebLoginViewController.self)!
        controller.modalPresentationStyle = .overFullScreen
        controller.header = .init(clientID: clientID, clientSecret: clientSecret)
        controller.request = .init(language: language, priorityCountries: countries)

        let navigation = UINavigationController(rootViewController: controller)
        let root = UIApplication.topViewController()
        root?.present(navigation, animated: true)
    }
}
