internal extension URL {

    static var base: URL {
        // FIXME: - Staging url will change into https://stg-core.human-id.org
        let path = HumanIDSDK.isStaging ? "https://core.human-id.org/staging" : "https://core.human-id.org"
        return URL(string: path)!
    }
}
