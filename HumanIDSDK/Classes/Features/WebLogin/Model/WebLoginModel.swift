internal struct WebLogin {

    struct Request {

        let language: String
        let priorityCountries: [String]

        var param: [String: Any] {
            get {
                return [
                    "lang": language,
                    "priority_country": priorityCountries.joined(separator: ",")
                ]
            }
        }
    }

    struct Response: Codable {

        let webLoginURL: String?

        enum CodingKeys: String, CodingKey {
            case webLoginURL = "webLoginUrl"
        }
    }

    struct ViewModel {

        let exchangeToken: String
    }
}
