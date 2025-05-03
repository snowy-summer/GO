//
//  QueryStringProtocol.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation

protocol QueryStringProtocol {
    
    func asQueryItems() -> [URLQueryItem]
    
}
