//
//  MockWebService.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import Foundation

class MockService: WebService {
    
    var hostURL: String = "http://localhost:8080/"
    
    func fetchShops(searchText: String, latitude: Double, longitude: Double, completion: @escaping ([Shop]?) -> Void) {
        
        let shop1 =  Shop (name: "Shop1",
                           shopId: "1",
                           contactNumber: "+91 9944991225",
                           latitude: 12.96099,
                           longitude: 80.24099,
                           address: "Perungudi - 635")
        let shop2 =  Shop (name: "Shop2",
                           shopId: "2",
                           contactNumber: "9944991225",
                           latitude: 12.96192,
                           longitude: 80.24192,
                           address: "Perungudi - 600096")
        
        let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            completion([shop1, shop2])
        }
    }
    
    func searchSuggestions(searchText: String, completion: @escaping ([String]?) -> Void)  {
        
        completion(nil)
    }
}
