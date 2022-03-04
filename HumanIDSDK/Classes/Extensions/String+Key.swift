internal extension String {

    static var webLoginPath: String {
        let version = "v0.0.3"
        return HumanIDSDK.isStaging ? "/mobile/users/web-login" : "\(version)/mobile/users/web-login"
    }
}
