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
    
    open func registerNotification(token: String) {
        KeyChain.isStoreSuccess(key: .notificationTokenKey, value: token)
    }
    
    open func verifyPhone(phoneNumber: String, countryCode: String, completion: @escaping (_ success: Bool, _ data: BaseResponse<DefaultResponse>) -> ()) {
        guard let appID = KeyChain.retrieveString(key: .appIDKey), let appSecret = KeyChain.retrieveString(key: .appSecretKey) else {
            completion(false, BaseResponse(message: "appID or appSecret not found", data: nil))
            return
        }
        
        let data = VerifyPhone(countryCode: countryCode, phone: phoneNumber, appId: appID, appSecret: appSecret)
        
        let jsonData = try? JSONEncoder().encode(data)
        Rest.post(url: .verifyPhone, data: jsonData, completion: {
            success, object, errormessage in
            
            guard let body = object, let response = try? JSONDecoder().decode(DefaultResponse.self, from: body) else {
                completion(success, BaseResponse(message: errormessage, data: nil))
                return
            }
            
            completion(success, BaseResponse(message: success.description, data: response))
        })
    }
    
    open func userRegistration(phoneNumber: String, countryCode: String, verificationCode: String, completion: @escaping (_ success: Bool, _ data: BaseResponse<DetailResponse>) -> ()) {
        guard
            let appID = KeyChain.retrieveString(key: .appIDKey),
            let appSecret = KeyChain.retrieveString(key: .appSecretKey)
        else {
            completion(false, BaseResponse(message: "appID or appSecret not found", data: nil))
            return
        }
        
        var notifID = ""
        if let token = KeyChain.retrieveString(key: .notificationTokenKey) {
            notifID = token
        }
        
        var deviceID = UUID().uuidString
        if let id = KeyChain.retrieveString(key: .deviceID) {
            deviceID = id
        } else {
            deviceID = "qwe23w12j3nj12b3j1b2nj3bj1b23jb1j2b3"
            //TODO: Generate deviceID try to communicate with humanid app
        }
        
        let data = UserRegistration(countryCode: countryCode, phone: phoneNumber, deviceId: deviceID, verificationCode: verificationCode, notifId: notifID, appId: appID, appSecret: appSecret)
        let jsonData = try? JSONEncoder().encode(data)
        
        Rest.post(url: .userRegistration, data: jsonData, completion: {
            success, object, errorMessage in
            guard let body = object, let response = try? JSONDecoder().decode(DetailResponse.self, from: body) else {
                completion(success, BaseResponse(message: errorMessage, data: nil))
                return
            }
            
            completion(success, BaseResponse(message: success.description, data: response))
        })
        
    }
    
    open func userLogin(hash: String, completion: @escaping (_ success: Bool, _ data: BaseResponse<DetailResponse>) -> ()) {
        guard
            let appID = KeyChain.retrieveString(key: .appIDKey),
            let appSecret = KeyChain.retrieveString(key: .appSecretKey)
        else {
            completion(false, BaseResponse(message: "appID or appSecret not found", data: nil))
            return
        }
        
        var notifID = ""
        if let token = KeyChain.retrieveString(key: .notificationTokenKey) {
            notifID = token
        }
        
        let data = UserLogin(existingHash: hash, notifId: notifID, appId: appID, appSecret: appSecret)
        let jsonData = try? JSONEncoder().encode(data)
        Rest.post(url: .userLogin, data: jsonData, completion: {
            success, object, errorMessage in
            guard let body = object, let response = try? JSONDecoder().decode(DetailResponse.self, from: body) else {
                completion(success, BaseResponse(message: errorMessage, data: nil))
                return
            }
            
            completion(success, BaseResponse(message: success.description, data: response))
        })
    }
}
