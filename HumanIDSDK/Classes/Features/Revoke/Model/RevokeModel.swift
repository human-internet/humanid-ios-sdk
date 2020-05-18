internal struct Revoke {

    struct Request: Codable {

        let appId: String
        let appSecret: String
        let userHash: String
    }
}
