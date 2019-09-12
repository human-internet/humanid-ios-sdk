//
//  UserRegistration.swift
//  SDK
//
//  Created by fanni suyuti on 12/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

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
