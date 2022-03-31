internal extension String {

    static var webLoginPath: String {
        let version = "v1"
        return "\(version)/mobile/users/web-login"
    }

    func getQueryParameter(from key: String) -> String? {
        guard let url = URLComponents(string: self) else { return nil }
        return url.queryItems?.first(where: { param in param.name == key })?.value
    }
}
