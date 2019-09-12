//
//  UpdatePhone.swift
//  SDK
//
//  Created by fanni suyuti on 12/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

struct UpdatePhone: Codable {
    let countryCode: String
    let phone: String
    let verificationCode: String
    let existingHash: String
    let appId: String
    let appSecret: String
}
