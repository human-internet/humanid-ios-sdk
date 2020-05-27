internal struct RequestOTP {

    struct Request: Codable {

        let countryCode: String
        let phone: String
        let appId: String
        let appSecret: String
    }
}
