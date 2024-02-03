//
//  DataRequest.swift
//  ProductMarket
//
//  Created by Polina on 23.01.2024.
//
import Foundation

protocol DataRequest {
    associatedtype Response
    var url: EndPoints { get }
    var method: HTTPMethods { get }
    func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Response.self, from: data)
    }
}
