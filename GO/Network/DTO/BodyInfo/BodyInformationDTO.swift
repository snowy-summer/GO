//
//  BodyInformationDTO.swift
//  GO
//
//  Created by 최승범 on 5/3/25.
//

import Foundation

struct BodyInformationDTO: Decodable {
    var id: UUID
    var userID: UUID
    var date: Date
    var weight: Double
    var muscleMass: Double
    var bodyFatMass: Double
    
//    func toModel() -> BodyInformation {
//        let model = BodyInformation()
//        model.id = self.id
//        model.userID = self.userID
//        model.date = self.date
//        model.weight = self.weight
//        model.muscleMass = self.muscleMass
//        model.bodyFatMass = self.bodyFatMass
//        return model
//    }
}
