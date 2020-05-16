internal struct Verify {

    struct Request: Codable {

        let countryCode: String
        let phone: String
        let appId: String
        let appSecret: String
    }

    struct Response: Codable {

        let success: Bool?
        let message: String?
    }
}
