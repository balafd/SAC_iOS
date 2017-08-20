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

    func fetchShopDetail(shopID: Int, completion: @escaping (Shop?, [TrendingTag]?, [TrendingTag]?) -> Void) {

        let path = hostURL + "shop/" + String(shopID)

        Alamofire.request(
            URL(string: path)!,
            method: .post,
            parameters: nil)
            .validate()
            .response(completionHandler: { (response) in
                print("response :")
                print(response)
            })
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching shop details: \(String(describing: response.result.error))")
                    completion(nil, nil, nil)
                    return
                }
                guard let value = response.result.value as? [String: Any], let result = value["results"] as? [String: Any], let statusCode = value["status_code"] as? Int else {
                    completion(nil, nil, nil)
                    return
                }
                if statusCode != 200 {
                    completion(nil, nil, nil)
                } else {
                    print("result : ")
                    print(result)
                }
        }
    }

    func registerShop(shop: Shop, description: String, tags: String, completion: @escaping (Int?) -> Void) {
        let path = hostURL + "shop"

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
                    print("Error while registering: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                guard let value = response.result.value as? [String: Any], let shopID = value["results"] as? Int, let statusCode = value["status_code"] as? Int else {
                    completion(nil)
                    return
                }
                if statusCode != 200 {
                    completion(nil)
                } else {
                    completion(shopID)
                }
        }
    }


    var hostURL: String = "http://localhost:3006/"


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
