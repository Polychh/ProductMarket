//
//  ProductViewModel.swift
//  ProductMarket
//
//  Created by Polina on 24.01.2024.
//

import Foundation
import Combine

final class ProductViewModel: ObservableObject{
    private let networkManager: NetworkManger
    private let imageDownloder = ImageDownloader()
    
    @Published var dataProduct: ProductModel.ProductArray = []
    @Published var filterProduct: ProductModel.ProductArray = []
    @Published var filterImageResProd = [String: Data]()
    @Published var imageResProd = [String: Data]()
   
    @Published var categoryChoosed: String = ""
    
    var isChanged: Bool = false
    var categoryName: String
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManger, categotyName: String) {
        self.networkManager = networkManager
        self.categoryName = categotyName
        fetchProductCategoryData(category: categoryName)
        updateRequest()
    }
    
    private func updateRequest(){
        $categoryChoosed
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else {return}
                if categoryChoosed == "Все" && isChanged{
                    fetchAllProducts()
                }else if isChanged{
                    fetchProductCategoryData(category: categoryChoosed)
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchProductCategoryData(category: String){
        let request = ProductBycategoryRequest(categoryName: category)
        Task{ @MainActor in
            do{
                let result = try await networkManager.request(request)
                dataProduct = result.sorted { $0.id < $1.id }
                imageResProd = try await fetchImageData(for: dataProduct)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchAllProducts(){
        let request = AllProducts()
        Task{ @MainActor in
            do{
                let result = try await networkManager.request(request)
                dataProduct = result.sorted { $0.id < $1.id }
                imageResProd = try await fetchImageData(for: dataProduct)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchImageData(for result: ProductModel.ProductArray ) async throws -> [String : Data] {
        var imageData: [String: Data] = [:]
        try await withThrowingTaskGroup(of: (String, Data).self) { group in
            for element in result {
                group.addTask {
                    return (element.title, try await self.imageDownloder.downloadImage(from: element.image))
                }
            }
            for try await (title, element) in group {
                imageData[title] = element
            }
        }
        return imageData
    }
}
