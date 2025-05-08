//
//  NetworkManager.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation
import Combine

final class NetworkManager: NSObject {
    
    private let session: URLSessionProtocol
    private let decoder = JSONDecoder()
    private var cancelable = Set<AnyCancellable>()
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
}

extension NetworkManager: NetworkManagerProtocol {
    func getData(from router: RouterProtocol,
                 retryCount: Int = 1) async throws -> Data {
        let (data, response) = try await session.getData(from: router)
        
        do {
            try validateResponse(response)
        } catch {
            if retryCount > 0 {
                LogManager.log("retryCount: \(retryCount) 원래 요청을 다시 시도합니다.")
                return try await getData(from: router,
                                         retryCount: retryCount - 1)
            }
            await handleErrorDataWithError(data: data)
            throw NetworkError.invalidResponse
        }
        
        return data
    }
    
    func getDecodedData<T>(from router: RouterProtocol,
                           type: T.Type,
                           retryCount: Int = 1) async throws -> T where T: Decodable {
        
        let (data, response) = try await session.getData(from: router)
        
        do {
            try validateResponse(response)
        } catch {
            if retryCount > 0 {
                LogManager.log("retryCount: \(retryCount) 원래 요청을 다시 시도합니다.")
                return try await getDecodedData(from: router,
                                                type: type,
                                                retryCount: retryCount - 1)
            }
            await handleErrorDataWithError(data: data)
            throw NetworkError.invalidResponse
        }

        return try decode(type, from: data)
    }
    
    func getDataWithPublisher(from router: RouterProtocol,
                              retryCount: Int = 1) -> AnyPublisher<Data, any Error> {
        session.getDataPublisher(from: router)
            .tryMap { (data, response) in
                try self.validateResponse(response)
                return data
            }
            .retry(retryCount)
            .catch { error in
                self.handleErrorDataWithErrorPublisher(error)
            }
            .eraseToAnyPublisher()
    }
    
    func getDecodedDataWithPublisher<T>(from router: RouterProtocol,
                                        type: T.Type,
                                        retryCount: Int = 1) -> AnyPublisher<T, any Error> where T : Decodable {
        session.getDataPublisher(from: router)
            .tryMap { (data, response) in
                try self.validateResponse(response)
                return try self.decoder.decode(T.self, from: data)
            }
            .retry(retryCount)
            .catch { error in
                self.handleErrorDataWithErrorPublisher(error)
            }
            .eraseToAnyPublisher()
    }
    
    
}

//MARK: - 유효성, Error핸들링
extension NetworkManager {
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NetworkError.invalidResponse }
        
        guard (200..<300) ~= statusCode else {
            LogManager.log("StatusCode: \(statusCode)")
            throw NetworkError.invalidResponse
        }
    }
    
    private func handleErrorDataWithError(data: Data) async {
        do {
            let errorData = try decoder.decode(ErrorDTO.self, from: data)
            LogManager.log("error: \(errorData.error)\n" + errorData.reason)
            
        } catch {
            LogManager.log(NetworkError.decodingFailed("ErrorDTO").description)
            
        }
    }
    
    private func handleErrorDataWithErrorPublisher(_ error: Error) -> AnyPublisher<Data, any Error> {
        return Fail(error: error)
            .handleEvents(receiveCompletion: { _ in
                LogManager.log("Network error handled in Publisher: \(error.localizedDescription)")
            })
            .eraseToAnyPublisher()
    }
    
    private func handleErrorDataWithErrorPublisher<T>(_ error: Error) -> AnyPublisher<T, any Error> {
        return Fail(error: error)
            .handleEvents(receiveCompletion: { _ in
                LogManager.log("Network error handled in Publisher: \(error.localizedDescription)")
            })
            .eraseToAnyPublisher()
    }
    
    private func decode<T: Decodable>(_ type: T.Type,
                                      from data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            LogManager.log(NetworkError.decodingFailed("\(type)").description)
            throw NetworkError.decodingFailed("\(type)")
        }
    }
}

