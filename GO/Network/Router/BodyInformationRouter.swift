//
//  BodyInformationRouter.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation

enum BodyInformationRouter {
    
    case postRecord
    case getUserRecord(UUID)
    case putUserRecord(UUID)
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
        case .getUserRecord(let id):
            return "/bodyInformation/user"
        case .putUserRecord(let uUID):
            return "/bodyInformation/update"
        case .deleteUserRecord(let uUID):
            return "/bodyInformation/delete"
        case .getUserRangeRecord(let uUID, let string, let string2):
            return "/bodyInformation/range"
        case .getUserdayRecord(let uUID, let string):
            return "/bodyInformation/date"
        }
    }
    
    var body: Data? {
        <#code#>
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .postRecord:
            return []
        case .getUserRecord(let userID):
            return GetBodyInfoQuery(userID: userID).asQueryItems()
        case .putUserRecord(let infoID):
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
    
    var responseType: (any Decodable.Type)? {
        <#code#>
    }
    
    
}
