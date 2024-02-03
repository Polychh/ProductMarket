//
//  EndPoints.swift
//  ProductMarket
//
//  Created by Polina on 23.01.2024.
//

import Foundation

enum EndPoints{
    private var baseURL: String { return "https://neobook.online/ecobak/" }
    
    case getCategoryList
    case getProductByCategory(categoryName: String)
    case getAllProducts

    var fullPath: String {
        var endpoint: String
        switch self{
        case .getCategoryList:
            endpoint = "product-category-list/"
        case .getProductByCategory(let categoryName):
            endpoint = "product-list/?category_name=\(categoryName)"
        case .getAllProducts:
            endpoint = "product-list/"
        }
        return baseURL + endpoint
    }
}
