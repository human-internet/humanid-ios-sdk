internal extension URL {

    static var base: URL {
        return URL(string: "https://humanid.herokuapp.com/")!
    }

    static var users: URL {
        return URL(string: "mobile/users/", relativeTo: base)!
    }

    static var verify: URL {
        return URL(string: "verifyPhone", relativeTo: users)!
    }

    static var register: URL {
        return URL(string: "register", relativeTo: users)!
    }

    static var revoke: URL {
        return URL(string: "revokeAccess", relativeTo: users)!
    }
}
