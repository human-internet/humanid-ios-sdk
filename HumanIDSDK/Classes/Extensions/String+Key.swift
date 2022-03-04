internal extension String {

    static var webLoginPath: String {
        let version = "v0.0.3"
        return HumanIDSDK.isStaging ? "/mobile/users/web-login" : "\(version)/mobile/users/web-login"
    }

    func getQueryParameter(from key: String) -> String? {
        guard let url = URLComponents(string: self) else { return nil }
        return url.queryItems?.first(where: { param in param.name == key })?.value
    }
}
