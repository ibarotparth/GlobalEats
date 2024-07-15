//
//  APIManager.swift
//  MealDB
//
//  Created by csuftitan on 10/26/23.
//

import UIKit

protocol APIManagerProtocol {
    func request<T: Decodable>(url: String) async throws -> T
}

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

final class APIManager: APIManagerProtocol   {
   
    static let shared = APIManager()
    private init() {}
    
    func request<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw DataError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw DataError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
