//
//  Array.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 07/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

extension Array {
    static var countries: [Country]? {
        return try? JSONDecoder().decode([Country].self, from: Data(countriesJSON.utf8))
    }
}
