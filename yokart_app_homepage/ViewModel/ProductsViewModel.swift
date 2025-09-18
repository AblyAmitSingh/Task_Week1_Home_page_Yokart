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
    
    private(set) var currentPage = 1
    private(set) var totalPageCount = 1
    private var isFetching = false
    private let pageSize = 5
    
    func fetchProductAPI(page: Int = 1) {
        guard !isFetching else {
            print("Already fetching page \(page)")
            return
        }
        guard page <= totalPageCount else {
            print("Page \(page) exceeds total page count \(totalPageCount)")
            return
        }
        
        guard let url = URL(string: "https://b2bdemo.yo-kart.com/app-api/2.4/home") else {
            print("Invalid URL")
            isFetching = false
            return
        }
        
        isFetching = true
        print("Fetching page \(page) with pageSize \(pageSize)")
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        
        body += Data("--\(boundary)\r\n".utf8)
        body += Data("Content-Disposition: form-data; name=\"page\"\r\n".utf8)
        body += Data("\r\n\r\n\(page)\r\n".utf8)
        
       
        body += Data("--\(boundary)--\r\n".utf8)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("PHPSESSID=8a6cf85cbeb4114f412ad5607749882b; screenWidth=769", forHTTPHeaderField: "Cookie")
        request.httpBody = body
        
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
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response for page \(page): \(jsonString)")
            } else {
                print("Failed to convert data to JSON string")
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ProductListModel.self, from: data)
                
                DispatchQueue.main.async {
                    if page == 1 {
                        self.productList = result
                        if let responsePage = Int(result.data?.page ?? "1"),
                           let responsePageCount = Int(result.data?.pageCount ?? "1") {
                            self.currentPage = responsePage
                            self.totalPageCount = responsePageCount
                            print("Pagination updated: currentPage = \(self.currentPage), totalPageCount = \(self.totalPageCount)")
                        } else {
                            print("Invalid page or pageCount in response")
                        }
                        print("Page 1: Set productList with \(result.data?.collections?.count ?? 0) items")
                    } else {
                        if let newCollections = result.data?.collections {
                            self.productList?.data?.collections?.append(contentsOf: newCollections)
                        } else {
                            print("No collections in response for page \(page)")
                        }
                    }
                    
                    if let responsePage = Int(result.data?.page ?? "1"),
                       let responsePageCount = Int(result.data?.pageCount ?? "1") {
                        self.currentPage = responsePage
//                        self.totalPageCount = responsePageCount
                        print("Pagination updated: currentPage = \(self.currentPage), totalPageCount = \(self.totalPageCount)")
                    } else {
                        print("Invalid page or pageCount in response")
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
            print("Loading next page: \(nextPage)")
            fetchProductAPI(page: nextPage)
        } else {
            print("Current: \(currentPage), Total: \(totalPageCount), isFetching: \(isFetching)")
        }
    }
    
    var isLoading: Bool {
        return isFetching
    }
}
