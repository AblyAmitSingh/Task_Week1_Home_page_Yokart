//
//  NetworkManager.swift
//  yokart_app_homepage
//
//  Created by User on 19/09/25.
//


import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func performRequest<T: Decodable>(urlString: String, 
                                    method: String = "POST",
                                    parameters: [String: Any]? = nil,
                                    headers: [String: String]? = nil,
                                    completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Set headers
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Set default headers if not provided
        if method == "POST" && request.value(forHTTPHeaderField: "Content-Type") == nil {
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            // Create body for POST request
            if let parameters = parameters {
                var body = Data()
                for (key, value) in parameters {
                    body += Data("--\(boundary)\r\n".utf8)
                    body += Data("Content-Disposition: form-data; name=\"\(key)\"\r\n".utf8)
                    body += Data("\r\n\(value)\r\n".utf8)
                }
                body += Data("--\(boundary)--\r\n".utf8)
                request.httpBody = body
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON response: \(jsonString)")
                }
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}