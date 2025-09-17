//
//  ProductsViewModel.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import Foundation

class ProductsViewModel {
    var onUpdate: (() -> Void)?
    private(set) var productList: ProductListModel?
    
    private var currentPage = 1
    private var totalPageCount = 1
    private var isFetching = false
    
    func fetchProductAPI(page: Int = 1) {
        guard !isFetching else { return }
        guard page <= totalPageCount else { return }
        
        guard let url = URL(string: "https://b2bdemo.yo-kart.com/app-api/2.4/home") else {
            isFetching = false
            return
        }
        
        isFetching = true
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params = ["page": page]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params)
        } catch {
            print("Error JSON body: \(error.localizedDescription)")
            isFetching = false
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            self.isFetching = false
            
            if let error = error {
                print("Error fetching products: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ProductListModel.self, from: data)
                
                DispatchQueue.main.async {
                    if page == 1 {
                        self.productList = result
                    } else {
                        if let newCollections = result.data?.collections {
                            let existingIds = self.productList?.data?.collections?.map { $0.collectionID } ?? []
                            let filteredCollections = newCollections.filter { !existingIds.contains($0.collectionID) }
                            self.productList?.data?.collections?.append(contentsOf: filteredCollections)
                        }
                    }
                    
                    if let responsePage = Int(result.data?.page ?? "1"),
                       let responsePageCount = Int(result.data?.pageCount ?? "1") {
                        self.currentPage = responsePage
                        self.totalPageCount = responsePageCount
                    }
                    
                    self.onUpdate?()
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func loadNextPage() {
        let nextPage = currentPage + 1
        if nextPage <= totalPageCount && !isFetching {
            fetchProductAPI(page: nextPage)
        }
    }
    
    var isLoading: Bool {
        return isFetching
    }
}
