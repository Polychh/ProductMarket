//
//  AllProducts.swift
//  ProductMarket
//
//  Created by Polina on 26.01.2024.
//

import Foundation

struct AllProducts: DataRequest{
    typealias Response = ProductModel.ProductArray
    
    var url: EndPoints{
        .getAllProducts
    }
    
    var method: HTTPMethods {
        .GET
    }
}
