//
//  String.swift
//  SDK
//
//  Created by fanni suyuti on 12/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

internal extension String {
    static var appIDKey: String {
        return "AppIDKeyForKeyChain"
    }
    
    static var appSecretKey: String {
        return "AppSecretKeyForKeyChain"
    }
    
    static var notificationTokenKey: String {
        return "NotificationTokenKeyForKeyChain"
    }
}
