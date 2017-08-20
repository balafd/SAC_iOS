//
//  Shop.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import Foundation
struct Shop {
    let id: Int
    let name: String
    let phone: String
    let latitude: Double
    let longitude: Double
    let address: String
    let ownerName: String
}

extension Shop {
    init(jsonDict: [String: Any]) throws {
        self.init(
            id: jsonDict["id"] as! Int,
            name: jsonDict["name"] as! String,
            phone: jsonDict["phone"] as! String,
            latitude: jsonDict["latitude"] as! Double,
            longitude: jsonDict["longitude"] as! Double,
            address: jsonDict["address"] as! String,
            ownerName: jsonDict["owner"] as! String
        )
    }
}


//address = "26, Srinivasa Nagar, Kandanchavadi, Perungudi, Chennai";
//id = 1;
//latitude = "12.9693";
//longitude = "80.2486";
//name = "Junior Kuppanna";
//phone = 0987654321;

