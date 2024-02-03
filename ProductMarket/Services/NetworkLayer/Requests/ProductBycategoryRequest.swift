//
//  ProductBycategoryRequest.swift
//  ProductMarket
//
//  Created by Polina on 24.01.2024.
//

import Foundation

struct ProductBycategoryRequest: DataRequest{
    typealias Response = ProductModel.ProductArray
    
    let categoryName: String
    
    var url: EndPoints{
        .getProductByCategory(categoryName: categoryName)
    }
    
    var method: HTTPMethods {
        .GET
    }
}
