//
//  BodyInfoRequestBody.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation

struct BodyInfoRequestBody: Encodable {
    
    let userID: UUID
    let date: Date
    let weight: Double
    let muscleMass: Double
    let bodyFatMass: Double
    
}
