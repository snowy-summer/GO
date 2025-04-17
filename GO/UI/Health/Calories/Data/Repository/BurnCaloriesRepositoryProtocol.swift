//
//  BurnCaloriesRepositoryProtocol.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

protocol BurnCaloriesRepositoryProtocol {
    func fetchCaloriesThisWeek() -> [BurnCaloriesData]
}

final class MockCaloriesRepository: BurnCaloriesRepositoryProtocol {
    func fetchCaloriesThisWeek() -> [BurnCaloriesData] {
        let dateManager = DateManager.shared
        return [
            BurnCaloriesData(calories: 720, date: dateManager.getDate(from: "2025.04.13")), // 일
            BurnCaloriesData(calories: 430, date: dateManager.getDate(from: "2025.04.14")), // 월
            BurnCaloriesData(calories: 590, date: dateManager.getDate(from: "2025.04.15")), // 화
            BurnCaloriesData(calories: 790, date: dateManager.getDate(from: "2025.04.16")), // 수
            BurnCaloriesData(calories: 610, date: dateManager.getDate(from: "2025.04.17")), // 목
            BurnCaloriesData(calories: 872, date: dateManager.getDate(from: "2025.04.18")), // 금
            BurnCaloriesData(calories: 400, date: dateManager.getDate(from: "2025.04.19"))  // 토
        ]
    }
}
