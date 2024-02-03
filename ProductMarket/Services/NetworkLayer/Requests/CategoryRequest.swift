//
//  CategoryRequest.swift
//  ProductMarket
//
//  Created by Polina on 23.01.2024.
//

import Foundation

struct CategoryRequest: DataRequest{
    
    typealias Response = CategoryModel.CategoryArray
    
    var url: EndPoints{
        .getCategoryList
    }
    
    var method: HTTPMethods {
        .GET
    }
}
