//
//  Header.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation

enum Header {
    
    case contentTypeJson
    case contentTypeMulti
    
    var key: String {
        switch self {
        case .contentTypeJson, .contentTypeMulti:
            return "Content-Type"
        }
    }
    
    var value: String {
        switch self {
        case .contentTypeJson:
            return "application/json"
            
        case .contentTypeMulti:
            return "multipart/form-data"
        }
        
    }
}
