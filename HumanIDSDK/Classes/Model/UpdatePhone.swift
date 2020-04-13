import Foundation

struct UpdatePhone: Codable {

    let countryCode: String
    let phone: String
    let verificationCode: String
    let existingHash: String
    let appId: String
    let appSecret: String
}
