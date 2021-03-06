open class HumanIDSDK {

    public static let shared = HumanIDSDK()

    private init() {}

    open func webLogin(with clientID: String, and clientSecret: String, language: String = SupportedLanguage.ENGLISH_US, countries: [String] = [CountryCode.UNITED_STATES]) {
        let controller = Injector.shared.resolve(WebLoginViewController.self)!
        controller.modalPresentationStyle = .overFullScreen
        controller.header = .init(clientID: clientID, clientSecret: clientSecret)
        controller.request = .init(language: language, priorityCountries: countries)

        let navigation = UINavigationController(rootViewController: controller)
        let root = UIApplication.topViewController()
        controller.delegate = root as? WebLoginDelegate

        root?.present(navigation, animated: true)
    }
}
