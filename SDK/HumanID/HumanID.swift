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
    
    open func userRegistration(phoneNumber: String, countryCode: String, verificationCode: String, completion: @escaping (_ success: Bool, _ object: String) -> ()) {
        guard
            let appID = KeyChain.retrieveString(key: .appIDKey),
            let appSecret = KeyChain.retrieveString(key: .appSecretKey),
            let notifID = KeyChain.retrieveString(key: .notificationTokenKey)
        else {
            completion(false, "appID or appSecret or notification token not found")
            return
        }
        
        var deviceID = ""
        if let id = KeyChain.retrieveString(key: .deviceID) {
            deviceID = id
        } else {
            //TODO: Generate deviceID try to communicate with humanid app
        }
        
        let data = UserRegistration(countryCode: countryCode, phone: phoneNumber, deviceId: deviceID, verificationCode: verificationCode, notifId: notifID, appId: appID, appSecret: appSecret)
        
    }
}
