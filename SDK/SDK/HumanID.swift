//
//  HumanID.swift
//  SDK
//
//  Created by fanni suyuti on 12/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

open class HumanID {
    
    private init() {}
    
    public static let shared = HumanID()
    
    open func config(appID: String, appSecret: String) {
        KeyChain.isStoreSuccess(key: .appIDKey, value: appID)
        KeyChain.isStoreSuccess(key: .appSecretKey, value: appSecret)
    }
    
    open func verifyPhone(phoneNumber: String, countryCode: String, completion: @escaping (_ success: Bool, _ object: String) -> ()) {
        guard let appID = KeyChain.retrieveString(key: .appIDKey), let appSecret = KeyChain.retrieveString(key: .appSecretKey) else {
            completion(false, "appID or appSecret not found")
            return
        }
        
        let data = VerifyPhone(countryCode: countryCode, phone: phoneNumber, appId: appID, appSecret: appSecret)
        
        let jsonData = try? JSONEncoder().encode(data)
        Rest.post(url: .verifyPhone, data: jsonData, completion: {
            success, object in
            guard let object = object else {
                completion(success, "no message")
                return
            }

            completion(success, object["message"] as? String ?? "")
        })
    }
}
