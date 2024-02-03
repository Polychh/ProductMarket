//
//  ImageCache.swift
//  ProductMarket
//
//  Created by Polina on 23.01.2024.
//

import UIKit
final class ImageCache{
    private var cache: [URL:Data] = [:]
    
    func cacheImage(_ image: Data, for url: URL){
        cache[url] = image
    }
    
    func image(for url: URL) -> Data?{
        return cache[url]
    }
}
