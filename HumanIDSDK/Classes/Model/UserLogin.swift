import Foundation

struct UserLogin: Codable {

    let existingHash: String
    let notifId: String
    let appId: String
    let appSecret: String
}
