//
//  RejectLogin.swift
//  HumanID
//
//  Created by fanni suyuti on 30/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

struct RejectLogin: Codable {
    let hash: String
    let requestingAppId: String
    let type: String
    let appId: String
    let appSecret: String
}
