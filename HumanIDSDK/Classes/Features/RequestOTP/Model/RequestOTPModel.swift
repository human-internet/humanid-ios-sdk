internal struct RequestOTP {

    struct Request: Codable {

        let countryCode: String
        let phone: String
    }
}
