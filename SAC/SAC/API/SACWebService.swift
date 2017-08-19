//
//  SACWebService.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import Foundation
import Alamofire

class SACWebService: WebService {
    
    var hostURL: String = "http://localhost:8080/"
    
    func fetchShops(searchText: String, latitude: Double, longitude: Double, completion: @escaping ([Shop]?) -> Void) {
        
        Alamofire.request(
            URL(string: hostURL)!,
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

