//
//  ErrorDTO.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation

struct ErrorDTO: Decodable {
    let error: Bool
    let reason: String
}
