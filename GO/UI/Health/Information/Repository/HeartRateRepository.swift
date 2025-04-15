//
//  HeartRateRepository.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

protocol HeartRateRepositoryProtocol {
    func fetchHeartRateThisWeek() -> [HeartRateData]
}

final class MockHeartRateRepository: HeartRateRepositoryProtocol {
    func fetchHeartRateThisWeek() -> [HeartRateData] {
        let dateManager = DateManager.shared
        return [

            HeartRateData(heartRate: 100, date: dateManager.getDate(from: "2025.04.13")), // 일
            HeartRateData(heartRate: 120, date: dateManager.getDate(from: "2025.04.14")), // 월
            HeartRateData(heartRate: 110, date: dateManager.getDate(from: "2025.04.15")), // 화
            HeartRateData(heartRate: 98, date: dateManager.getDate(from: "2025.04.16")), // 수
            HeartRateData(heartRate: 200, date: dateManager.getDate(from: "2025.04.17")), // 목
            HeartRateData(heartRate: 160, date: dateManager.getDate(from: "2025.04.18")), // 금
            HeartRateData(heartRate: 88, date: dateManager.getDate(from: "2025.04.19"))  // 토
        ]
    }
}
