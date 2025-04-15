//
//  CaloriesRepositoryProtocol.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

protocol CaloriesRepositoryProtocol {
    func fetchCaloriesThisWeek() -> [CaloriesData]
}

final class MockCaloriesRepository: CaloriesRepositoryProtocol {
    func fetchCaloriesThisWeek() -> [CaloriesData] {
        let dateManager = DateManager.shared
        return [
            CaloriesData(calories: 720, date: dateManager.getDate(from: "2025.04.13")), // 일
            CaloriesData(calories: 430, date: dateManager.getDate(from: "2025.04.14")), // 월
            CaloriesData(calories: 590, date: dateManager.getDate(from: "2025.04.15")), // 화
            CaloriesData(calories: 790, date: dateManager.getDate(from: "2025.04.16")), // 수
            CaloriesData(calories: 610, date: dateManager.getDate(from: "2025.04.17")), // 목
            CaloriesData(calories: 872, date: dateManager.getDate(from: "2025.04.18")), // 금
            CaloriesData(calories: 400, date: dateManager.getDate(from: "2025.04.19"))  // 토
        ]
    }
}
