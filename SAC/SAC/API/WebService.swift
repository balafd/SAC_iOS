//
//  WebService.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import Foundation
import Alamofire

protocol WebService {
    
    func fetchShops(searchText: String, latitude: Double, longitude: Double, completion: @escaping ([Shop]?) -> Void)
    func searchSuggestions(searchText: String, completion: @escaping ([String]?) -> Void)
}


class MockService: WebService {
    
    func fetchShops(searchText: String, latitude: Double, longitude: Double, completion: @escaping ([Shop]?) -> Void) {
        
        let shop1 =  Shop (name: "Shop1", shopId: "1", contactNumber: "+91 9944991225", latitude: 12.96099, longitude: 80.24099, address: "Perungudi - 635")
        let shop2 =  Shop (name: "Shop2", shopId: "2", contactNumber: "9944991225", latitude: 12.96192, longitude: 80.24192, address: "Perungudi - 600096")
        
        completion([shop1, shop2])
    }
    
    func searchSuggestions(searchText: String, completion: @escaping ([String]?) -> Void)  {
        
        completion(nil)
    }
}

class SACWebService: WebService {
    func fetchShops(searchText: String, latitude: Double, longitude: Double, completion: @escaping ([Shop]?) -> Void) {
        
        Alamofire.request(
            URL(string: "http://localhost:5984/shops/_all_docs")!,
            method: .get,
            parameters: ["searchText": searchText, "lat": latitude, "long": longitude])
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                    completion(nil)
                    return
                }
                print(value)
                
//                                guard let value = response.result.value as? [String: Any], let rows = value["rows"] as? [[String: Any]] else {
                //                        print("Malformed data received from fetchAllRooms service")
                //                        completion(nil)
                //                        return
                //                }
                //
                //                let rooms = rows.flatMap({ (roomDict) -> RemoteRoom? in
                //                    return RemoteRoom(jsonData: roomDict)
                //                })
                
                completion([Shop]())
        }
    }
    
    func searchSuggestions(searchText: String, completion: @escaping ([String]?) -> Void) {
        
        completion(nil)
    }
}



