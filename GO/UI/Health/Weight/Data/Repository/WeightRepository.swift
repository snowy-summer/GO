//
//  WeightRepository.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import Foundation

protocol WeightRepositoryProtocol {
    func fetchWeightRecentSeven() -> [WeightData]
}

final class MockWeightRepository: WeightRepositoryProtocol {
    func fetchWeightRecentSeven() -> [WeightData] {
        let dateManager = DateManager.shared
        return [
            WeightData(weight: 71.8, muscleMass: 27.2, bodyFatMass: 24, date: dateManager.getDate(from: "2025.04.13")), // 일
            WeightData(weight: 72.8, muscleMass: 27.4, bodyFatMass: 23.5, date: dateManager.getDate(from: "2025.04.14")), // 월
            WeightData(weight: 73.8, muscleMass: 27.5, bodyFatMass: 23.8, date: dateManager.getDate(from: "2025.04.15")), // 화
            WeightData(weight: 74.8, muscleMass: 27.3, bodyFatMass: 24.2, date: dateManager.getDate(from: "2025.04.16")), // 수
            WeightData(weight: 72.8, muscleMass: 27.1, bodyFatMass: 23.6, date: dateManager.getDate(from: "2025.04.17")), // 목
            WeightData(weight: 71.5, muscleMass: 27.0, bodyFatMass: 22.9, date: dateManager.getDate(from: "2025.04.18")), // 금
            WeightData(weight: 72.1, muscleMass: 27.2, bodyFatMass: 23.1, date: dateManager.getDate(from: "2025.04.19"))  // 토
        ]
    }
}

