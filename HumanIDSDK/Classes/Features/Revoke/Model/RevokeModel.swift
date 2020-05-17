internal struct Revoke {

    struct Request: Codable {

        let appId: String
        let appSecret: String
        let userHash: String
    }

    struct Response: Codable {

        let success: Bool?
        let message: String?
    }
}