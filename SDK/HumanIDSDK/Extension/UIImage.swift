//
//  UIImage.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 16/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

extension UIImage {
    static func fromSDK(name: String) -> UIImage? {
        return UIImage(named: name, in: Bundle(identifier: "org.humanid.HumanIDSDK"), compatibleWith: nil)
    }
}
