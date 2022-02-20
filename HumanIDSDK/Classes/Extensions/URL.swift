internal extension URL {

    static var base: URL {
        let path = HumanIDSDK.isSandbox ? "https://sandbox.human-id.org/v0.0.3/" : "https://core.human-id.org/v0.0.3/"
        return URL(string: path)!
    }

    static var baseV2: URL {
        let path = HumanIDSDKV2.isStaging ? "https://core.human-id.org/staging/" : "https://core.human-id.org/"
        return URL(string: path)!
    }

    static var tnc: URL {
        return URL(string: "https://human-id.org/#how-we-protect/")!
    }

    static var users: URL {
        return URL(string: "mobile/users/", relativeTo: base)!
    }

    static var requestOtp: URL {
        let locale = Locale.current.regionCode?.lowercased() ?? "en"
        return URL(string: "login/request-otp?lang=\(locale)", relativeTo: users)!
    }

    static var login: URL {
        return URL(string: "login", relativeTo: users)!
    }
}
