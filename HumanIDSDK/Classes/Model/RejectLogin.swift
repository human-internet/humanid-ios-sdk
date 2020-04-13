import Foundation

struct RejectLogin: Codable {

    let hash: String
    let requestingAppId: String
    let type: String
    let appId: String
    let appSecret: String
}
