//
//  MockWebService.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import Foundation

class MockService: WebService {
    func registerShop(shop: Shop, description: String, tags: String, completion: @escaping (Int?) -> Void) {
        
    }
    
    
    var hostURL: String = "http://192.168.1.2:3006/"
    
    func searchSuggestions(searchText: String, completion: @escaping ([Tag]?) -> Void) {
        
        let tag1 = Tag.init(id: 1, name: "Anything")
        let tag2 = Tag.init(id: 2, name: "Something")
        let tag3 = Tag.init(id: 3, name: "Everything")
        completion([tag1, tag2, tag3])
    }
    
    func fetchShops(tagID: Int, latitude: Double, longitude: Double, completion: @escaping ([Shop]?) -> Void) {
        
        let shop1 =  Shop (id: 1,
                           name: "Shop1",
                           phone: "+91 9944991225",
                           latitude: 12.96099,
                           longitude: 80.24099,
                           address: "Perungudi - 635",
                           ownerName: "")
        let shop2 =  Shop (id: 2,
                           name: "Shop2",
                           phone: "9944991225",
                           latitude: 12.96192,
                           longitude: 80.24192,
                           address: "Perungudi - 600096",
                           ownerName: "")
        
        let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            completion([shop1, shop2])
        }
    }
    
}
