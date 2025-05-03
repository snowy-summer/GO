//
//  URLSession+Extension.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation

extension URLSession: URLSessionProtocol {
    
    func getData(from router: RouterProtocol) async throws -> (Data, URLResponse) {
        
        let request = try RequestBuilder()
            .setRouter(router)
            .build()
        return try await data(for: request)
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    
}

extension URLRequest {
    
    init(url: URL, method: HTTPMethod, headers: [String: String] = [:]) throws {
        self.init(url: url)
        
        httpMethod = method.rawValue
        allHTTPHeaderFields = headers
    }
    
}
