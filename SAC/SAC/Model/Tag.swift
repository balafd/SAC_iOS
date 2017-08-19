//
//  Tag.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import Foundation
struct Tag {
    let id: String
    let name: String
}

extension Tag {
    init(jsonDict: [String: Any]) throws {
        self.init(
            id: jsonDict["id"] as! String,
            name: jsonDict["name"] as! String
        )
    }
}
