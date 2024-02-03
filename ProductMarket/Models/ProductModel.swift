//
//  ProductModel.swift
//  ProductMarket
//
//  Created by Polina on 24.01.2024.
//

import Foundation
struct ProductModel: Decodable{
    typealias ProductArray = [ProductModel]
    let id: Int
    let title, description: String
    let category: Int
    let image: String
    let quantity: Int
    let price: String
}
