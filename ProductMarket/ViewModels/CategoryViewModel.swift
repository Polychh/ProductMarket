//
//  CategoryViewModel.swift
//  ProductMarket
//
//  Created by Polina on 23.01.2024.
//

import Foundation

final class CategoryViewModel: ObservableObject{
    private let networkManager: NetworkManger
    private let imageDownloder = ImageDownloader()
    
    @Published var data: CategoryModel.CategoryArray = []
    @Published var imageResult: [String : Data] = [:]

    init(networkManager: NetworkManger) {
        self.networkManager = networkManager
        fetchCategoryData()
    }
    
    private func fetchCategoryData(){
        let request = CategoryRequest()
        Task{ @MainActor in
            do{
                let result = try await networkManager.request(request)
                data = result
                imageResult = try await fetchImageData(for: data)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchImageData(for result: CategoryModel.CategoryArray) async throws -> [String : Data] {
        var imageData: [String: Data] = [:]
        try await withThrowingTaskGroup(of: (String, Data).self) { group in
            for element in result {
                group.addTask {
                    return (element.name, try await self.imageDownloder.downloadImage(from: element.image))
                }
            }
            for try await (name, element) in group {
                imageData[name] = element
            }
        }
        return imageData
    }
}
