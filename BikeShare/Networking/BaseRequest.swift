//
//  BaseRequest.swift
//  BikeShare
//
//  Created by Daniel Slone on 12/2/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import Foundation

enum ApiResponse<A, B> {
    case success(result: A)
    case failed(error: B)
}
enum ApiMethod: String {
    case GET
    case POST
}
class BaseRequest {

    func request<T: Codable>(url: String, method: ApiMethod, parameters: [String: String]?, headers: [String: String]?, completion: @escaping (ApiResponse<T, Error>) -> Void) {
        guard let serviceUrl = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let parameters = parameters, let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = httpBody
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failed(error: error))
            } else if let data = data {
                do {
                    let defaultBodyResponse = try T.init(jsonData: data)
                    completion(.success(result: defaultBodyResponse))
                } catch {
                    completion(.failed(error: error))
                }
            }
        }.resume()
    }
}
extension Decodable {
    init(jsonData: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: jsonData)
    }
}
