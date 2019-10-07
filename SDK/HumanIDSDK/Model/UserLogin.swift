//
//  UserLogin.swift
//  SDK
//
//  Created by fanni suyuti on 12/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

struct UserLogin: Codable {
    let existingHash: String
    let notifId: String
    let appId: String
    let appSecret: String
}
