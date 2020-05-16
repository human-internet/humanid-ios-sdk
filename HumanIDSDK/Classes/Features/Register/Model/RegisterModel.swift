internal struct Register {

    struct Request: Codable {

        let countryCode: String
        let phone: String
        let deviceId: String
        let verificationCode: String
        let notifId: String
        let appId: String
        let appSecret: String
    }

    struct Response: Codable {

        let success: Bool?
        let message: String?
        let data: Data?

        struct Data: Codable {

            let exchangeToken: String?
            let userHash: String?
        }
    }

    struct ViewModel {

        let token: String
        let hash: String
    }
}
