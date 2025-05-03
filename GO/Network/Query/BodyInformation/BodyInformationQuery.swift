//
//  BodyInformationQuery.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation

struct GetBodyInfoQuery: QueryStringProtocol {
    
    private let userID: UUID
    
    init(userID: UUID) {
        self.userID = userID
    }
    
    func asQueryItems() -> [URLQueryItem] {
        return [URLQueryItem(name: "user_id", value: userID.uuidString)]
    }
    
}


struct PutBodyInfoQuery: QueryStringProtocol {
    
    private let infoID: UUID
    
    init(infoID: UUID) {
        self.infoID = infoID
    }
    
    func asQueryItems() -> [URLQueryItem] {
        return [URLQueryItem(name: "id", value: infoID.uuidString)]
    }
    
}

struct DeleteBodyInfoQuery: QueryStringProtocol {
    
    private let infoID: UUID
    
    init(infoID: UUID) {
        self.infoID = infoID
    }
    
    func asQueryItems() -> [URLQueryItem] {
        return [URLQueryItem(name: "id", value: infoID.uuidString)]
    }
    
}

struct GetBodyInfoRangeQuery: QueryStringProtocol {
    
    private let userID: UUID
    private let start: String // yyyy-MM-dd
    private let end: String // yyyy-MM-dd
    
    init(userID: UUID,
         start: String,
         end: String) {
        self.userID = userID
        self.start = start
        self.end = end
    }
    
    func asQueryItems() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "user_id", value: userID.uuidString),
            URLQueryItem(name: "start", value: start),
            URLQueryItem(name: "end", value: end),
        ]
    }
    
}

struct GetBodyInfoDateQuery: QueryStringProtocol {
    
    private let userID: UUID
    private let date: String // yyyy-MM-dd
    
    init(userID: UUID,
         date: String) {
        self.userID = userID
        self.date = date
    }
    
    func asQueryItems() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "user_id", value: userID.uuidString),
            URLQueryItem(name: "date", value: date)
        ]
    }
    
}
