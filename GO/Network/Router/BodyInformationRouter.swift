//
//  BodyInformationRouter.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation

enum BodyInformationRouter {
    
    case postRecord(body: BodyInfoRequestBody)
    case getUserRecord(UUID)
    case putUserRecord(UUID, body: BodyInfoRequestBody)
    case deleteUserRecord(UUID)
    case getUserRangeRecord(UUID, String, String)
    case getUserdayRecord(UUID, String)
    
}

extension BodyInformationRouter: RouterProtocol {
    var scheme: String { return "http" }
    
    var host: String? { "localhost" }
    
    var port: Int? { return 8080 }
    
    var path: String {
        switch self {
        case .postRecord:
            return "/bodyInformation"
        case .getUserRecord:
            return "/bodyInformation/user"
        case .putUserRecord:
            return "/bodyInformation/update"
        case .deleteUserRecord:
            return "/bodyInformation/delete"
        case .getUserRangeRecord:
            return "/bodyInformation/range"
        case .getUserdayRecord:
            return "/bodyInformation/date"
        }
    }
    
    var encodableBody: Encodable? {
        switch self {
        case .postRecord(let body):
            return body
        case .putUserRecord(_, let body):
            return body
        default:
            return nil
        }
    }

    var body: Data? {
        guard let encodable = encodableBody else { return nil }
        return try? JSONEncoder().encode(encodable)
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .postRecord:
            return []
        case .getUserRecord(let userID):
            return GetBodyInfoQuery(userID: userID).asQueryItems()
        case .putUserRecord(let infoID, _):
            return PutBodyInfoQuery(infoID: infoID).asQueryItems()
        case .deleteUserRecord(let infoID):
            return DeleteBodyInfoQuery(infoID: infoID).asQueryItems()
        case .getUserRangeRecord(let userID, let start, let end):
            return GetBodyInfoRangeQuery(userID: userID, start: start, end: end).asQueryItems()
        case .getUserdayRecord(let userID, let date):
            return GetBodyInfoDateQuery(userID: userID, date: date).asQueryItems()
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = query
        
        return components.url
    }
    
    var headers: [String : String] {
        var headers = [
            Header.contentTypeJson.key: Header.contentTypeJson.value
        ]
        
        return headers
    }
    
    var method: HTTPMethod {
        switch self {
        case .postRecord:
            return .post
        case .getUserRecord:
            return .get
        case .putUserRecord:
            return .put
        case .deleteUserRecord:
            return .delete
        case .getUserRangeRecord:
            return .get
        case .getUserdayRecord:
            return .get
        }
    }
    
    var responseType: Decodable.Type? {
        switch self {
        case .postRecord:
            return BodyInformationDTO.self
        case .getUserRecord:
            return [BodyInformationDTO].self
        case .putUserRecord:
            return BodyInformationDTO.self
        case .deleteUserRecord:
            return nil
        case .getUserRangeRecord:
            return [BodyInformationDTO].self
        case .getUserdayRecord:
            return [BodyInformationDTO].self
        }
    }
    
    
}
