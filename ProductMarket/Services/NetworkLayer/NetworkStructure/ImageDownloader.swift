//
//  ImageDownloader.swift
//  ProductMarket
//
//  Created by Polina on 23.01.2024.
//

import UIKit
final class ImageDownloader{
    private let imageCache = ImageCache()
    
    func downloadImage(from string: String) async throws -> Data {
        guard let url = URL(string: string) else{ throw PMErrors.invalidURL}
        if let cachedImage = imageCache.image(for: url){
            return cachedImage
        }
        let data = try await downloadImageData(from: url)
        imageCache.cacheImage(data, for: url)
        return data
    }
    
    private func downloadImageData(from url: URL) async throws -> Data{
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw PMErrors.invalidResponse}
        return data
    }
    
}
