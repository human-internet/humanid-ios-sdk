internal extension URL {

    static var base: URL {
        let path = HumanIDSDK.isStaging ? "https://s-api.human-id.org" : "https://api.human-id.org"
        return URL(string: path)!
    }
}
