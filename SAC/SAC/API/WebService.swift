//
//  WebService.swift
//  SAC
//
//  Created by Bala on 19/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import Foundation

protocol WebService {
    var hostURL: String { get }
    func fetchShops(searchText: String, latitude: Double, longitude: Double, completion: @escaping ([Shop]?) -> Void)
    func searchSuggestions(searchText: String, completion: @escaping ([String]?) -> Void)
}

