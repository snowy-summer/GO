//
//  WaterRepository.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation

protocol WaterRepositoryProtocol {
    func fetchWaterThisWeek() -> [WaterData]
}

final class MockWaterRepository: WaterRepositoryProtocol {
    func fetchWaterThisWeek() -> [WaterData] {
        let dateManager = DateManager.shared
        return [
            WaterData(amount: 1.1, date: dateManager.getDate(from: "2025.04.13")), // 일
            WaterData(amount: 1.2, date: dateManager.getDate(from: "2025.04.14")), // 월
            WaterData(amount: 1.5, date: dateManager.getDate(from: "2025.04.15")), // 화
            WaterData(amount: 1.7, date: dateManager.getDate(from: "2025.04.16")), // 수
            WaterData(amount: 2.1, date: dateManager.getDate(from: "2025.04.17")), // 목
            WaterData(amount: 0.4, date: dateManager.getDate(from: "2025.04.18")), // 금
            WaterData(amount: 1.9, date: dateManager.getDate(from: "2025.04.19"))  // 토
        ]
    }
}
