//
//  NetworkService.swift
//  ProductMarket
//
//  Created by Polina on 23.01.2024.
//

import Foundation

protocol NetworkManger {
    func request<Request: DataRequest>(_ request: Request) async throws -> Request.Response
}

final class NetworkService: NetworkManger {
    func request<Request: DataRequest>(_ request: Request) async throws -> Request.Response {
        guard let url = URL(string: request.url.fullPath) else{ throw PMErrors.invalidURL}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw PMErrors.invalidResponse}
        do{
            let productInfo = try request.decode(data)
            return productInfo
        }catch{
            throw PMErrors.invalidData
        }
    }
}
