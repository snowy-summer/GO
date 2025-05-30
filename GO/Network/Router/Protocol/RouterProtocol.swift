//
//  RouterProtocol.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation

protocol RouterProtocol {
    
    var scheme: String { get }
    var host: String? { get }
    var path: String { get }
    var port: Int? { get }
    var body: Data? { get }
    var query: [URLQueryItem] { get }
    var url: URL? { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    var responseType: Decodable.Type? { get }
//    var multipartFormData: [MultipartFormData] { get }
    
}
