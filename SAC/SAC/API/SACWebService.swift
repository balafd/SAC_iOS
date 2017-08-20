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
    func registerShop(shop: Shop, description: String, tags: String, completion: @escaping (Shop?) -> Void) {
        let path = hostURL + "shop"
        //curl localhost:3006/shop -d "name=secondshop&description=doe&phone=123&owner=me&address=sampleadd&category_id=1&latitude=1.22&longitude=1.23&tags=shampoo"

        let params : [String: Any] = ["name": shop.name,
                                      "latitude": shop.latitude,
                                      "longitude": shop.longitude,
                                      "description": description,
                                      "address": shop.address,
                                      "category_id": 1,
                                      "phone": shop.phone,
                                      "tags": tags
                                      ]
        Alamofire.request(
            URL(string: path)!,
            method: .post,
            parameters: params)
            .validate()
            .response(completionHandler: { (response) in
                print("response :")
                print(response)
            })
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                guard let value = response.result.value as? [String: Any], let statusCode = value["status_code"] as? Int else {
                    completion(nil)
                    return
                }
                if statusCode != 200 {
                    completion(nil)
                    return
                } else {
                    completion(shop)
                }
        }
    }
    
    
    var hostURL: String = "http://192.168.1.2:3006/"
    
    func fetchShops(tagID: Int, latitude: Double, longitude: Double, completion: @escaping ([Shop]?) -> Void) {
        let path = hostURL + "search"
        let params : [String: Any] = ["tagId": tagID,
                                      "latitude": latitude,
                                      "longitude": longitude]
        Alamofire.request(
            URL(string: path)!,
            method: .get,
            parameters: params)
            .validate()
            .response(completionHandler: { (response) in
                print("response :")
                print(response)
            })
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                guard let value = response.result.value as? [String: Any], let rows = value["results"] as? [[String:Any]], let statusCode = value["status_code"] as? Int else {
                    completion([Shop]())
                    return
                }
                if statusCode != 200 {
                    completion([Shop]())
                    return
                } else {
                    print(value)
                    let shops = rows.flatMap({ (shopDict) -> Shop? in
                        do {
                            return try Shop(jsonDict: shopDict)
                        } catch {
                            print("Error : " + error.localizedDescription)
                            print(shopDict)
                        }
                        return nil
                    })
                    completion(shops)
                }
        }
    }
    
    func searchSuggestions(searchText: String, completion: @escaping ([Tag]?) -> Void) {
        let path = hostURL + "search_suggest"
        let params : [String: Any] = ["search_text": searchText]
        Alamofire.request(
            URL(string: path)!,
            method: .get,
            parameters: params)
            .validate()
            .response(completionHandler: { (response) in
                print("response :")
                print(response)
            })
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                guard let value = response.result.value as? [String: Any], let rows = value["results"] as? [[String:Any]], let statusCode = value["status_code"] as? Int else {
                    completion([Tag]())
                    return
                }
                print(value)
                
                if statusCode != 200 {
                    completion([Tag]())
                    return
                } else {
                    let tags = rows.flatMap({ (tagDict) -> Tag? in
                        do {
                            return try Tag(jsonDict: tagDict)
                        } catch {
                            print("Error : " + error.localizedDescription)
                            print(tagDict)
                        }
                        return nil
                    })
                    completion(tags)
                }
        }
    }
}

