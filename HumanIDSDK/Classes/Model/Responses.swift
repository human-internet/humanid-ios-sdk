import Foundation

public struct BaseResponse<T: Codable>: Codable {

    let message: String?
    let data: T?
}

public struct DefaultResponse: Codable {

    let message: String
}

public struct DetailResponse: Codable {

    let result: Data?

    struct Data: Codable {

        let exchangeToken: String
        let userHash: String
    }

    enum CodingKeys: String, CodingKey {
        case result = "data"
    }
}
