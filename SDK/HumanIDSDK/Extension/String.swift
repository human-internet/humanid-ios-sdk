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
    
    static var deviceID: String {
        return "DeviceIDKeyForKeyChain"
    }
    
    static var userHash: String {
        return "UserHashKeyForKeyChain"
    }
}

extension String {
    internal static func atributedFormat(
        strings: [String],
        boldFont: UIFont = UIFont.boldSystemFont(ofSize: 14),
        boldColor: UIColor = UIColor.blue,
        inString string: String,
        font: UIFont = UIFont.systemFont(ofSize: 14), color: UIColor = UIColor.black
    ) -> NSAttributedString {
        
        let attributedString =
            NSMutableAttributedString(string: string,
                                    attributes: [
                                        NSAttributedString.Key.font: font,
                                        NSAttributedString.Key.foregroundColor: color
            ])
        let boldFontAttribute = [NSAttributedString.Key.font: boldFont, NSAttributedString.Key.foregroundColor: boldColor]
        for bold in strings {
            attributedString.addAttributes(boldFontAttribute, range: (string as NSString).range(of: bold))
        }
        
        return attributedString
    }
}
