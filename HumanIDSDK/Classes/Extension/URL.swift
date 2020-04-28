internal extension URL {

    static var base: URL {
        return URL(string: "https://humanid.herokuapp.com/mobile/")!
    }

    static var verifyPhone: URL {
        return URL(string: "users/verifyPhone", relativeTo: base)!
    }

    static var userRegistration: URL {
        return URL(string: "users/register", relativeTo: base)!
    }
}
