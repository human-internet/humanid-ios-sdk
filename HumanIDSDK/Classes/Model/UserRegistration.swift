import Foundation

struct UserRegistration: Codable {

    let countryCode: String
    let phone: String
    let deviceId: String
    let verificationCode: String
    let notifId: String
    let appId: String
    let appSecret: String
}
