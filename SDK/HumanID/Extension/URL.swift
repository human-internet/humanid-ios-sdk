//
//  URL.swift
//  SDK
//
//  Created by fanni suyuti on 11/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

internal extension URL {
    static var base: URL {
        return URL(string: "http://localhost:3000/")!
//        return URL(string: "https://humanid.herokuapp.com/mobile/")!
    }
    
    static var loginCheck: URL {
        return URL(string: "users/login", relativeTo: base)!
    }
    
    static var updatePhone: URL {
        return URL(string: "users/updatePhone", relativeTo: base)!
    }
    
    static var update: URL {
        return URL(string: "users", relativeTo: base)!
    }
    
    static var userLogin: URL {
        return URL(string: "users/login", relativeTo: base)!
    }
    
    static var userRegistration: URL {
        return URL(string: "users/register", relativeTo: base)!
    }
    
    static var verifyPhone: URL {
        return URL(string: "users/verifyPhone", relativeTo: base)!
    }
    
}
