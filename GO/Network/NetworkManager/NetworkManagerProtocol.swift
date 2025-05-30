//
//  NetworkManagerProtocol.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    
    func getData(from router: RouterProtocol,
                 retryCount: Int) async throws -> Data
    func getDecodedData<T:Decodable>(from router: RouterProtocol,
                                     type: T.Type,
                                     retryCount: Int) async throws -> T
    func getDataWithPublisher(from router: RouterProtocol,
                              retryCount: Int) -> AnyPublisher<Data, Error>
    func getDecodedDataWithPublisher<T: Decodable>(from router: RouterProtocol,
                                                   type: T.Type,
                                                   retryCount: Int) -> AnyPublisher<T, Error>
    
}
