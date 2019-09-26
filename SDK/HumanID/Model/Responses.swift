//
//  Responses.swift
//  HumanID
//
//  Created by fanni suyuti on 26/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

public struct BaseResponse<T: Codable>: Codable {
    let message: String?
    let data: T?
}

public struct DefaultResponse: Codable {
    let message: String
}

public struct DetailResponse: Codable {
    let appId: String
    let hash: String
    let deviceId: String
    let notifId: String?
}
