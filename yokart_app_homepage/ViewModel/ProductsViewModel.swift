//
//  ProductsViewModel.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import Foundation

class ProductsViewModel {
    var onUpdate: (() -> Void)?
    var productList: ProductListModel?
    var productDetails: ProductDetailModel?
    
    var currentPage = 1
    var totalPageCount = 1
    var currentDetailsPage = 1
    var totalDetailsPageCount = 1
    private var isFetching = false
    private var isFetchingDetails = false
    private let pageSize = 5
    private let baseURL = "https://b2bdemo.yo-kart.com/app-api/2.4"
    
    func fetchProductAPI(page: Int = 1, endpoint: String = "/home") {
        guard !isFetching else {
            print("Already fetching products page \(page)")
            return
        }
        guard page <= totalPageCount else {
            return
        }
        
        isFetching = true
        
        let headers = [
            "Cookie": "PHPSESSID=8a6cf85cbeb4114f412ad5607749882b; screenWidth=769"
        ]
        
        let parameters = ["page": page]
        
        NetworkManager.shared.performRequest(urlString: baseURL + endpoint,
                                           parameters: parameters,
                                           headers: headers) { [weak self] (result: Result<ProductListModel, Error>) in
            guard let self = self else { return }
            self.isFetching = false
            
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    if page == 1 {
                        self.productList = result
                        if let responsePage = Int(result.data?.page ?? "1"),
                           let responsePageCount = Int(result.data?.pageCount ?? "1") {
                            self.currentPage = responsePage
                            self.totalPageCount = responsePageCount
                        }
                    } else {
                        if let newCollections = result.data?.collections {
                            self.productList?.data?.collections?.append(contentsOf: newCollections)
                        } else {
                            print("No collections data for page \(page)")
                        }
                    }
                    
                    if let responsePage = Int(result.data?.page ?? "1"),
                       let responsePageCount = Int(result.data?.pageCount ?? "1") {
                        self.currentPage = responsePage
                        print("Pagination updated currentPage = \(self.currentPage), totalPageCount = \(self.totalPageCount)")
                    } else {
                        print("Invalid page or pageCount in response")
                    }
                    
                    self.onUpdate?()
                }
                
            case .failure(let error):
                print("Error fetching products: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchProductDetailsAPI(productId: String, page: Int = 1, endpoint: String = "/products/view/") {
           guard !isFetchingDetails else {
               print("Already fetching product details for page \(page)")
               return
           }
           guard page <= totalDetailsPageCount else {
               print("No more pages to fetch. Total pages: \(totalDetailsPageCount)")
               return
           }
           
           isFetchingDetails = true
           
           let headers = [
               "Cookie": "PHPSESSID=8a6cf85cbeb4114f412ad5607749882b; screenWidth=769"
           ]
           
           let parameters = ["page": page] as [String: Any]
           let fullEndpoint = endpoint + productId
           print("Fetching URL: \(baseURL + fullEndpoint)")
           
           NetworkManager.shared.performRequest(urlString: baseURL + fullEndpoint,
                                              parameters: parameters,
                                              headers: headers) { [weak self] (result: Result<ProductDetailModel, Error>) in
               guard let self = self else { return }
               self.isFetchingDetails = false
               
               switch result {
               case .success(let result):
                   DispatchQueue.main.async {
                       if page == 1 {
                           self.productDetails = result
                           print("first page data \(result)")
                       } else {
                           if let newData = result.data?.data {
                               self.productDetails?.data?.data?.append(contentsOf: newData)
                           }
                       }
                       
                       if let pageCount = Int(result.data?.pageCount ?? "1") {
                           self.totalDetailsPageCount = pageCount
                           self.currentDetailsPage = page
                       }
                       
                       print("Fetched page \(page) of \(self.totalDetailsPageCount)")
                       self.onUpdate?()
                   }
                   
               case .failure(let error):
                   print("Error fetching product details: \(error.localizedDescription)")
               }
           }
       }

    
    func loadNextPage() {
        let nextPage = currentPage + 1
        if nextPage <= totalPageCount && !isFetching {
            print("Loading next products page: \(nextPage)")
            fetchProductAPI(page: nextPage)
        } else {
            print("Products - Current: \(currentPage), Total: \(totalPageCount), isFetching: \(isFetching)")
        }
    }
    
    
    func loadNextDetailsPage(productId: String) {
        let nextPage = currentDetailsPage + 1
        if nextPage <= totalDetailsPageCount && !isFetchingDetails {
            fetchProductDetailsAPI(productId: productId, page: nextPage)
        } else {
            print("No more pages to load. Current: \(currentDetailsPage), Total: \(totalDetailsPageCount), isFetchingDetails: \(isFetchingDetails)")
        }
    }
    
    var isLoading: Bool {
        return isFetching
    }
    
    var isLoadingDetails: Bool {
        return isFetchingDetails
    }
}
