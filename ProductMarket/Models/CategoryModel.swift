//
//  CategoryModel.swift
//  ProductMarket
//
//  Created by Polina on 23.01.2024.
//

import Foundation


struct CategoryModel: Decodable{
    typealias CategoryArray = [CategoryModel]
    let id: Int
    let name: String
    let image: String
}
