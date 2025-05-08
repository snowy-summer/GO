//
//  URLSession+Extension.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation
import Combine

extension URLSession: URLSessionProtocol {
    
    func getData(from router: RouterProtocol) async throws -> (Data, URLResponse) {
        
        let request = try RequestBuilder()
            .setRouter(router)
            .build()
        return try await data(for: request)
    }
    
    func getDataPublisher(from router: RouterProtocol) -> AnyPublisher<(Data, URLResponse), URLError> {
        do {
            let request = try RequestBuilder()
                .setRouter(router)
                .build()
            
            return self.dataTaskPublisher(for: request)
                .map { ($0.data, $0.response) }
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
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
