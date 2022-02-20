internal struct BaseResponse<T: Codable>: Codable {

    let code: String?
    let data: T?
    let message: String?
    let success: Bool?
}
