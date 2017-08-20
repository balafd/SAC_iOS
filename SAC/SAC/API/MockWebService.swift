//
//  MockWebService.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import Foundation

class MockService: WebService {
    
    func fetchShopDetail(shopID: Int, completion: @escaping (Shop?, [TrendingTag]?, [TrendingTag]?) -> Void) {
    
        let shop = Shop.init(id: 674,
                             name: "Annan Kadai",
                             phone: "8849499299",
                             latitude: 20.412,
                             longitude: 80.452,
                             address: "44sks kksk k",
                             ownerName: "bala")
        
        let taf = Tag.init(id: 1, name: "Shampoo")
        let taf1 = Tag.init(id: 2, name: "Hair oil")
        
        let inventoryTrendTag1 = TrendingTag.init(tag: taf, count: 14)
        let inventoryTrendTag2 = TrendingTag.init(tag: taf1, count: 53)
        let inventoryTrendTags = [inventoryTrendTag1, inventoryTrendTag2]
        
        let tagSuggested1 = Tag.init(id: 11, name: "Tooth Paste")
        let tagSuggested2 = Tag.init(id: 22, name: "Scrub")
        
        let suggestedTrendTag1 = TrendingTag.init(tag: tagSuggested1, count: 43)
        let suggestedTrendTag2 = TrendingTag.init(tag: tagSuggested2, count: 13)
        let suggestedTrends = [suggestedTrendTag1, suggestedTrendTag2]
        completion(shop, inventoryTrendTags, suggestedTrends)
    }
    
    func registerShop(shop: Shop, description: String, tags: String, completion: @escaping (Int?) -> Void) {
        
    }
    
    var hostURL: String = "http://192.168.2.71:3006/"
    
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
