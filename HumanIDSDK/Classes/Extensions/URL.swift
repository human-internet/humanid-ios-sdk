internal extension URL {

    static var base: URL {
        let path = HumanIDSDK.isSandbox ? "https://sandbox.human-id.org/v0.0.3/" : "https://core.human-id.org/v0.0.3/"
        return URL(string: path)!
    }

    static var tnc: URL {
        return URL(string: "https://human-id.org/#how-we-protect/")!
    }

    static var users: URL {
        return URL(string: "mobile/users/", relativeTo: base)!
    }

    static var requestOtp: URL {
        return URL(string: "login/request-otp", relativeTo: users)!
    }

    static var login: URL {
        return URL(string: "login", relativeTo: users)!
    }
}
