internal struct BaseResponse<T: Codable>: Codable {

    let success: Bool?
    let message: String?
    let data: T?
}

internal struct NetworkResponse: Codable {

    let code: String?
}
