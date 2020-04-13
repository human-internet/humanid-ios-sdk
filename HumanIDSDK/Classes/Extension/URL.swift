import Foundation

internal extension URL {

    static var base: URL {
        return URL(string: "https://humanid.herokuapp.com/mobile/")!
    }

    static var loginCheck: URL {
        return URL(string: "users/login", relativeTo: base)!
    }

    static var updatePhone: URL {
        return URL(string: "users/updatePhone", relativeTo: base)!
    }

    static var update: URL {
        return URL(string: "users", relativeTo: base)!
    }

    static var userLogin: URL {
        return URL(string: "users/login", relativeTo: base)!
    }

    static var userRegistration: URL {
        return URL(string: "users/register", relativeTo: base)!
    }

    static var verifyPhone: URL {
        return URL(string: "users/verifyPhone", relativeTo: base)!
    }

    static var rejectLogin: URL {
        return URL(string: "users/reject", relativeTo: base)!
    }

    static var confirmLogin: URL {
        return URL(string: "users/confirm", relativeTo: base)!
    }
}
