//
//  URLSessionProtocol.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation
import Combine

protocol URLSessionProtocol {
    
    func getData(from router: RouterProtocol) async throws -> (Data, URLResponse)
    func getDataPublisher(from router: RouterProtocol) -> AnyPublisher<(Data, URLResponse), URLError>
}

protocol URLSessionDataTaskProtocol {
    
    func resume()
    
}
