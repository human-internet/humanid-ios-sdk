internal struct Login {

    struct Request: Codable {

        let countryCode: String
        let phone: String
        let deviceId: String
        let verificationCode: String
    }

    struct Response: Codable {

        let exchangeToken: String?
        let userHash: String?
    }

    struct ViewModel {

        let token: String
        let hash: String
    }
}
