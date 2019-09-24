//
//  Keychain.swift
//  SDK
//
//  Created by fanni suyuti on 12/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

internal class KeyChain {
    
    internal class func isStoreSuccess(key: String, data: Data) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        if SecItemAdd(query as CFDictionary, nil) == noErr {
            return true
        } else {
            return false
        }
    }
    
    internal class func retrieve(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    internal class func isStoreSuccess(key: String, value: String) -> Bool {
        if let data = value.data(using: .utf8) {
            return isStoreSuccess(key: key, data: data)
        } else {
            return false
        }
    }
    
    internal class func retrieveString(key: String) -> String? {
        if let data = retrieve(key: key) {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
}
